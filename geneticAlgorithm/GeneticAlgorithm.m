% Author: Cristian Manuel Bernal Bernal
% Exercice Zmin = x^2+y^2+2*z^2-x*y-y*z-x*z
%          S.t. 0.14*x + 0.11*y + 0.1*z ≥ 120
%               x1 + x2 + x3 = 1000
%               x,y,z >= 0
clc;
clear all;

%% Variable initialization
lCromNumber=800;
lProbabilityC = 0.3;
lProbabilityM = 0.2;
lTotalMutations = lProbabilityM*lCromNumber*3;
j=1;
lDesv=0;
rDesv=100;
min=100000;
solmin=[];

%% Initial population
for i=1:lCromNumber
    r1=rand(1,1)*500;
    r2=rand(1,1)*500;
    lInitialPopulation(i,:) = [1000-r1-r2 r1 r2];
end

%% Main loop
while j<=10000
    lTotalFitness = 0;
    lSelectionProbability = [];
    lTempPopulation = [];
    lCumulProbability = [];
    lRandList = [];
    lCrossSelected = [];
    lTempCross = [];
    
    %% Selection Process
    for i = 1:lCromNumber
        lSelectionProbability(i) = 1/(1+fu_objective(lInitialPopulation(i,1),lInitialPopulation(i,2),lInitialPopulation(i,3)));
        lTotalFitness = lTotalFitness+lSelectionProbability(i);
    end
    
    lSelectionProbability = lSelectionProbability*(1/lTotalFitness);
    
    for i = 1:lCromNumber
        if i==1
            lCumulProbability(1)=lSelectionProbability(1);
        elseif i==lCromNumber
            lCumulProbability(lCromNumber)=1;
        else
            lCumulProbability(i)=lSelectionProbability(i)+lCumulProbability(i-1);
        end
    end
    
    lRandList = rand(lCromNumber,1);
    
    for i = 1:lCromNumber
        lTempPopulation(i,:)=lInitialPopulation(fu_class(lCumulProbability,lRandList(i)),:);
        if lRandList(i)<lProbabilityC
            lTempCross=[lTempCross;[lTempPopulation(i,:) i]];
        end
    end
    
    lInitialPopulation = lTempPopulation;
    
    %% Crossing process
    if(length(lTempCross)~=0)
    for i = 1:length(lTempCross(:,1))
        if(i==length(lTempCross(:,1)))
            lInitialPopulation(lTempCross(i,4),:)=[lTempCross(i) lTempCross(1,2:3)];
        else
            lInitialPopulation(lTempCross(i,4),:)=[lTempCross(i) lTempCross(i+1,2:3)];
        end
    end
    end
    
    %% Mutation process
    lCromMutated = round(rand(1,lTotalMutations)*(lCromNumber*3-1)+1);
    lValCromMutated = rand(1,lTotalMutations)*1000;
    for i=1:length(lCromMutated)
       lInitialPopulation(lCromMutated(i))=lValCromMutated(i);
    end
    
    for i=1:lCromNumber
       g=(0.14*lInitialPopulation(i,1)+0.11*lInitialPopulation(i,2)+0.1*lInitialPopulation(i,3));
       h=(lInitialPopulation(i,1)+lInitialPopulation(i,2)+lInitialPopulation(i,3));
       lSelectionProbability(i)=fu_objective_m(lInitialPopulation(i,1),lInitialPopulation(i,2),lInitialPopulation(i,3));
       if lSelectionProbability(i)<min && g>=120 && h<1001 && h>999
           min=lSelectionProbability(i);
           solmin=lInitialPopulation(i,:);
       end
    end
    if lDesv~=0
        rDesv=lDesv-std(lSelectionProbability);
    end
    lDesv=std(lSelectionProbability);
    j=j+1
end

%% Final output
fprintf("X1 = %f\n",solmin(1))
fprintf("X2 = %f\n",solmin(2))
fprintf("Z = %f\n", min)