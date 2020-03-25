%% Return the objective function value without constraint penality

function r = fu_objective_m(x,y,z)
	r=(0.2*x^2+0.08*y^2+0.18*z^2+0.1*x*y+0.04*x*z+0.06*y*z);
end