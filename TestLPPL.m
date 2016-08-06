load Data.mat
N = length(Data.Prices);

% There's one suggestion£º
% you'd better try different start points for the 
% optimization. The optimization problem is non-convex
% thus different start points may lead to different results,
% check all these answers and find out what you want!
% 
LPPLModel = LPPL();
% N+200 is start point for the optimization
LPPLModel.Train(1:N, Data.Prices, N+200);
Y = LPPLModel.Predict(1:N);
plot(1:N, Data.Prices, 1:N, Y);
legend('exact', 'fitted');

fprintf('=========================\n');
fprintf('crash time is %f\n', LPPLModel.tc);

