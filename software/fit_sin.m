function params = fit_sin(x, y, initial_params)

mx = @(initial_params)cost_func(initial_params, x, y);
params = fminsearch(mx, initial_params);


    function cost = cost_func(initial_params, x, y)
        value = initial_params(1) * sin(initial_params(2)*x - initial_params(3));
        cost = sum((value-y).^2);
    end

end