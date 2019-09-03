#Definicion del error
error = 0.001;
syms x y z t;

#funcion objetivo
funcion = [x^2+y^2+2*z^2-x*y-y*z-x*z];
vars = [x y z];

#Solución inicial
sol = [10 10 10];
condicion = true;
iteraciones = 0;

#Gradiente de la función objetivo
gradiente = jacobian(funcion);

while condicion
    
    iteraciones = iteraciones+1;
    
    #Gradiente evaluado en la solución actual
    gradientex = subs(gradiente,vars,sol);
    
    #Inicio nueva solución actual
    xj = [sol(1)-t*gradientex(1), sol(2)-t*gradientex(2), sol(3)-t*gradientex(3)];
    
    ft = subs(funcion,vars,xj);
    
    dft = jacobian(ft);
    
    ts = solve(dft);
    
    sol = subs(xj,t,ts);
    #fin nueva solución actual
    
    if (gradientex(1)<error & gradientex(2)<error & gradientex(3)<error)
        condicion = false
    end
    
end

iteraciones

sol