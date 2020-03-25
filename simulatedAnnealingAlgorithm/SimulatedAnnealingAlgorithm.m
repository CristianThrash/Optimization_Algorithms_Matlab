% Author: Cristian Manuel Bernal Bernal
% Exercice Zmax = 9*x+24*y+x*y-x^2-6*y^2
%          S.t. x + 5*y = 30
%               x,y >= 0

clc;
clear all;
cla;
hold on;

c = 0.8;
Ra = [-0.5 0.5];
k = 1;
q = 10;
n = 1;

%% Find initial temperature
x_ini = [];
y_ini = [];
l_ObjectiveFunction = [];

for i = 1:4
    y_ini(i) = rand(1,1)*6;
    x_ini(i) = 30 - 5*y_ini(i);
    l_ObjectiveFunction(i) = fun_objective(x_ini(i),y_ini(i));
end

To = mean(l_ObjectiveFunction);

%% Find the first solution with penality for a random number
l_y = rand(1,1)*6;
l_x = 30 - 5*y_ini(i);
T = fu_objective_pen(l_x,l_y);

%% Main loop
for j = 1:10000
    %% Neighbor solution
    l_V = [l_x+Ra(1) l_x+Ra(2);l_y+Ra(1) l_y+Ra(2)];
    
    u1 = rand(1,1);
    u2 = rand(1,1);
    
    r1 = l_V(1,1)+u1*(l_V(1,2)-l_V(1,1));
    r2 = l_V(2,1)+u2*(l_V(2,2)-l_V(2,1));
    
    Tn = fu_objective_pen(r1,r2);
    
    %% Acceptance of the solution
    if Tn > T
        accepted = true;
    else
        %% Metropolis criteria
        P = exp(-1*(Tn-T)/(k*To));
        A = rand(1,1);
        if(A<=P)
            accepted = true;
        else
            accepted = false;
        end
    end
    
    %% Extras
    if accepted
        l_x = r1;
        l_y = r2;
        T = Tn;
        To = To*c;
        j = j+1;
        pause(0.01)
        scatter3(l_x,l_y,fun_objective(l_x,l_y));
    end
end

%% Final output
fprintf("X1 = %f\n",l_x)
fprintf("X2 = %f\n",l_y)
fprintf("Z = %f\n",fun_objective(l_x,l_y))
