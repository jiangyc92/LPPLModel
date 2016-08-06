function Y = Predict(obj, X)
dt = obj.tc - X;
[M, N] = size(X);
Y = obj.A * ones(M,N) + obj.B * dt.^ obj.m + ...
    obj.C1 * dt .^ obj.m .* cos(obj.omega .* log(dt)) + ...
    obj.C2 * dt .^ obj.m .* sin(obj.omega .* log(dt));
Y = exp(Y);
end