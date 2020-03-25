% Author: Cristian Manuel Bernal Bernal
% Exercice Zmin = x^2+y^2+2*z^2-x*y-y*z-x*z

clc;
clear all;

%% Error definition
error = 0.001;

%% Objective function to minimize
syms x y z t;
objectiveFunction = [x^2+y^2+2*z^2-x*y-y*z-x*z];
vars = [x y z];

%% Initial Solution
sol = [10 10 10];
condition = true;
iterations = 0;

%% Objective function gradient
gradient = jacobian(objectiveFunction);

fprintf("\nF(x,y,z)=x^2+y^2+2*z^2-x*y-y*z-x*z\n\n")

fprintf("\ni     X1       X2        X3      |GX1      GX2      GX3 \n\n")

%% Loop
while condition
    
    iterations = iterations+1;
    
    %% Grandient evaluated in the current solution
    gradientx = subs(gradient,vars,sol);
    
    %% New solution
    xj = [sol(1)-t*gradientx(1), sol(2)-t*gradientx(2), sol(3)-t*gradientx(3)];
    
    ft = subs(objectiveFunction,vars,xj);
    
    dft = jacobian(ft);
    
    ts = solve(dft);
    sol = subs(xj,t,ts);
    
    fprintf("%-5d %-5f %-5f %-5f |%-5f %-5f %-5f \n", iterations, sol(1), sol(2), sol(3), abs(gradientx(1)),abs(gradientx(2)),abs(gradientx(3)))
    
    %% Detention criteria evaluation
    gradientx = subs(gradient,vars,sol);
    if (abs(gradientx(1))<=error && abs(gradientx(2))<=error && abs(gradientx(3))<=error)
        condition = false;
    end
end

%% Final output
fprintf("\n Iterations = %d\n\n",iterations)

fprintf("X1 = %f\n",sol(1))
fprintf("X2 = %f\n",sol(2))
fprintf("X3 = %f\n",sol(3))
fprintf("Z = %f\n",subs(objectiveFunction,vars,sol))