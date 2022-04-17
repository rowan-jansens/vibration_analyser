function params = fit_sin(x, y, f, initial_params)

mx = @(initial_params)cost_func(initial_params, x, y, f);
params = fminsearch(mx, initial_params);


    function cost = cost_func(initial_params, x, y, f)
        value = initial_params(1) * sin(f*x - initial_params(2));
        cost = sum((value-y).^2);
    end

end