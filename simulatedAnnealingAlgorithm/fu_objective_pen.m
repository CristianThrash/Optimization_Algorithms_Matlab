%% Return the objective function value with constraint penality

function r = fu_objective_pen(x,y)
	r = fun_objective(x,y)-10*abs(x+5*y-30);
end