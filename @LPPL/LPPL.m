% LPPL class try to fit the following problem:
% \[
% \ln p(t) = A + B(t_c - t)^m + C_1(t_c-t)^2\cos[\omega\ln(t_c-t)]
%          + C_2(t_c-t)^m\sin[\omega\ln(t_c-t)]
% \]
%  Then the optimization problem will be
% \[
% \min \sum_i [\ln p(t_i) - A - B(t_c - t_i)^m - C_1(t_c-t_i)^2\cos[\omega\ln(t_c-t_i)]
%         - C_2(t_c-t_i)^m\sin[\omega\ln(t_c-t_i)]^2
% \]
classdef LPPL < handle
    properties
        tc                          % crash time
        omega                       % angular frequency
        m                           % power order
        A
        B
        C1
        C2
        TrainRes
    end
    
    methods
        Train(obj, X, Y, t0);
        Y = Predict(obj, X);
    end
end