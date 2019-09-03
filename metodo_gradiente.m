%%Autor: Cristian Manuel Bernal Bernal

%%Definicion del error
error = 0.001;
syms x y z t;

%funcion objetivo
funcion = [x^2+y^2+2*z^2-x*y-y*z-x*z];
vars = [x y z];

%Solución inicial
sol = [10 10 10];
condicion = true;
iteraciones = 0;

%Gradiente de la función objetivo
gradiente = jacobian(funcion);

fprintf("\nF(x,y,z)=x^2+y^2+2*z^2-x*y-y*z-x*z\n\n")

fprintf("\ni     X1       X2        X3      |GX1      GX2      GX3 \n\n")

while condicion
    
    iteraciones = iteraciones+1;
    
    %Gradiente evaluado en la solución actual
    gradientex = subs(gradiente,vars,sol);
    
    %Inicio nueva solución actual
    xj = [sol(1)-t*gradientex(1), sol(2)-t*gradientex(2), sol(3)-t*gradientex(3)];
    
    ft = subs(funcion,vars,xj);
    
    dft = jacobian(ft);
    
    ts = solve(dft);
    sol = subs(xj,t,ts);
    %fin nueva solución actual
    
    fprintf("%-5d %-5f %-5f %-5f |%-5f %-5f %-5f \n", iteraciones, sol(1), sol(2), sol(3), abs(gradientex(1)),abs(gradientex(2)),abs(gradientex(3)))
    
    %criterio de detención
    gradientex = subs(gradiente,vars,sol);
    if (abs(gradientex(1))<=error && abs(gradientex(2))<=error && abs(gradientex(3))<=error)
        condicion = false;
    end
    
end

fprintf("\n Iteraciones = %d\n\n",iteraciones)

fprintf("X1 = %f\n",sol(1))
fprintf("X2 = %f\n",sol(2))
fprintf("X3 = %f\n",sol(3))