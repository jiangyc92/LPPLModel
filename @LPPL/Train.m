function Train(obj, Times, Prices, t0)
% Train function solve the optimization problem and get the optimal
% paramater
% obj: class instantce
% Times: time sequence ( suggested to be 1:N)
% Prices: prices list
% t0: the start point for the optimization

ObjFunc = @(t) Func2(t, Times, log(Prices));
OptimProblem = createOptimProblem('fmincon','objective',ObjFunc,'lb',max(Times), ...
    'x0',t0,'options',optimset('Display', 'iter'));
[tmin, Fmin] = fmincon(OptimProblem);
obj.tc = tmin;

[~, Para] = Func2(obj.tc, Times, log(Prices));
obj.m = Para.m;
obj.omega = Para.omega;

[~, Para] = Func1(tmin, obj.m, obj.omega, Times, log(Prices));
obj.A = Para.A;
obj.B = Para.B;
obj.C1 = Para.C1;
obj.C2 = Para.C2;

obj.TrainRes = Fmin;
end

function [Value, Para] = Func2(t, Times, LogPrices)

ObjSubFunc = @(x)Func1(t, x(1), x(2), Times, LogPrices);
OptimSubProblem = createOptimProblem('fmincon','objective',ObjSubFunc,...
    'lb',[0,0],'ub',[1,Inf],...
    'x0',[0.5,2],'options',optimset('Display','off'));
[Xmin,Fmin] = fmincon(OptimSubProblem);

Para.m = Xmin(1);
Para.omega = Xmin(2);

Value = Fmin;
end

function [Value, Para] = Func1(t, m, omega, Times, LogPrices)
dt = t - Times;
N = length(dt);
X = zeros(N,4);

X(:,1) = 1.0;
X(:,2) = dt.^m; 
X(:,3) = (dt.^m) .* cos(omega*log(dt));
X(:,4) = (dt.^m) .* sin(omega*log(dt));
Coef = regress(LogPrices, X);
Para.A = Coef(1);
Para.B = Coef(2);
Para.C1 = Coef(3);
Para.C2 = Coef(4);

Value = sum((LogPrices - X*Coef).^2);
end

