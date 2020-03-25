% Author: Cristian Manuel Bernal Bernal
% Exercice Zmin = (x-3)^2+(y-5)^2

clc;
clear all;

%% Algorithm parameters
c1 = 1;
c2 = 1;
tmin = 0.4;
tmax = 0.9;
imax = 20;
min = 100000;

%% Swarm size definition
l_SwarmSize = 4;

%% Initial population definition
l_Population = rand(l_SwarmSize,2)*5;

%% Objective function evaluation
l_ObjectiveFunction = [];
for i = 1:l_SwarmSize
    for k= 1:l_SwarmSize
        l_ObjectiveFunction(i,k) = fu_objective(l_Population(i,1),l_Population(k,2));
        if l_ObjectiveFunction(i,k)<min
            min = l_ObjectiveFunction(i,k);
            l_Gbest = [l_Population(i,1),l_Population(k,2)];
        end
    end
end

%% Initial velocity 0
l_PartVelocity = zeros(l_SwarmSize,2);

%% Selection of Pbest and Gbest (The last one is already selected in this case)
l_Pbest = zeros(l_SwarmSize,2)+10;
for i = 1:l_SwarmSize
    for k= 1:l_SwarmSize
        if l_ObjectiveFunction(i,k)<fu_objective(l_Pbest(i,1),l_Pbest(i,2))
            l_Pbest(i,:) = [l_Population(i,1),l_Population(k,2)];
        end
    end
end
j = 1;

%% Main loop
while j <= imax && std(l_ObjectiveFunction(:))>0.0001
    %% Find iteration velocities
    theta = tmax-((tmax-tmin)/imax)*j;
    r1 = rand(1,1);
    r2 = rand(1,1);
    for i = 1:l_SwarmSize
        l_PartVelocity(i,:) = theta*l_PartVelocity(i,:)+c1*r1*(l_Pbest(i,:)-l_Population(i,:))+c2*r2*(l_Gbest-l_Population(i,:));
        %% Find iteration positions of particles
        l_Population(i,:) = l_Population(i,:)+l_PartVelocity(i,:);
    end

    %% Evaluate the objective function and find the new Gbest
    for i = 1:l_SwarmSize
        for k= 1:l_SwarmSize
            l_ObjectiveFunction(i,k) = fu_objective(l_Population(i,1),l_Population(k,2));
            if l_ObjectiveFunction(i,k)<min
                min = l_ObjectiveFunction(i,k);
                l_Gbest = [l_Population(i,1),l_Population(k,2)];
            end
        end
    end

    %% Find new Pbest
    for i = 1:l_SwarmSize
        for k= 1:l_SwarmSize
            if l_ObjectiveFunction(i,k)<fu_objective(l_Pbest(i,1),l_Pbest(i,2))
                l_Pbest(i,:) = [l_Population(i,1),l_Population(k,2)];
            end
        end
    end
    j = j + 1;
end

%% Final output
fprintf("X1 = %f\n",l_Gbest(1))
fprintf("X2 = %f\n",l_Gbest(2))
fprintf("Z = %f\n",min)