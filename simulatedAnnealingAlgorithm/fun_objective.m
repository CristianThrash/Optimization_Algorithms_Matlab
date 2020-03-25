%% Return the objective function value without constraint penality

function r = fun_objective(x,y)
	r = 9*x+24*y+x*y-x^2-6*y^2;
end