# LPPLModel

##简介
LPPLModel使用对数周期幂律模型(Log Period Power Law)求解股票市场的崩盘时间，LPPL模型把股价表示为如下函数<br>
\\[<br>
\ln p(t) = A + B(t_c - t)^m + C_1(t_c-t)^2\cos[\omega\ln(t_c-t)]<br> + C_2(t_c-t)^m\sin[\omega\ln(t_c-t)]<br>
\\]<br>
我们需要求解A,B,C_1,C_2,\omega,m,t_c,这里t_c就是崩盘时间。在求解时，实际上求解了如下优化问题<br>
\\[<br>
\min \sum_i [\ln p(t_i) - A - B(t_c - t_i)^m - C_1(t_c-t_i)^2\cos[\omega\ln(t_c-t_i)]<br>
    >     - C_2(t_c-t_i)^m\sin[\omega\ln(t_c-t_i)]^2<br>
\\]<br>

##结构
LPPLModel结构如下
* `TestLPPL.m`: 测试文件，如何使用LPPLModel请参看该文件
* `@LPPL`: LPPL类
* `Data.mat`: 测试数据，为2015年A股崩盘前的上证指数分钟收盘价

LPPLModel中主要包括一个LPPL的handle类，该类有两个成员函数
* `Train(obj, X, Y, t0)`: 实现模型训练，即获得A,B,C_1,C_2,t_c,m,\omega参数
* `Y = Predict(obj, X)`: 预测，使用该模型预测时间为X(X<t_c)时的股价，一般用来看模型的拟合情况
