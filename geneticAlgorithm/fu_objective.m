%% Return the objective function value with constraint penality

function r = fu_objective(x,y,z)
	r=(0.2*x^2+0.08*y^2+0.18*z^2+0.1*x*y+0.04*x*z+0.06*y*z)+50000*(-1*0.14*x-0.11*y-0.1*z+120)+80000*(abs(x+y+z-1000)-10);
end