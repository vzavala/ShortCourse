% matlab example #13 - linear regression in matlab
% see https://www.mathworks.com/help/stats/understanding-linear-regression-outputs.html

clc
clear all
close all hidden

load data_ex16_8.dat
data=data_ex16_8
[n,m]=size(data)

% get input and output data (add column of ones)
X=[ones(n,1) data(:,2:3)]
Y=data(:,1)

% obtain best fit parameters
theta=inv(X'*X)*X'*Y

% get predictions
Yhat=X*theta

% get residuals
e=Y-Yhat

% root of mean squared error
rmse=sqrt(mean(e.^2))

% get R2
Ybar=mean(Y);
SSR=norm(Yhat-Ybar)^2;
SSE=norm(Yhat-Y)^2;
SSy=norm(Y-Ybar)^2;

R2=100*SSR/SSy

% visualize fit
figure(1)
x=linspace(min(Y)-1,max(Y)+1);
plot(Y,Yhat,'o')
hold on
plot(x,x)
axis([min(Y)-1 max(Y)+1 min(Y)-1 max(Y)+1])
xlabel('Experimental Output')
ylabel('Predicted Output')

% visualize residuals
figure(2)
histfit(e,[],'Normal')
xlabel('Residual')
ylabel('Frequency')

% assume variance of error is from  sample
sig2=var(e)

% get covariance matrix for parameters
C=inv(X'*X)*sig2

% confidence 95% intervals
chi= chi2inv(0.95,1);
conf=sqrt(diag(C)*chi);
theta
[theta-conf,theta+conf]

% try matlab built-in functions
X = data(:,2:3);
Y = data(:,1);
lm = fitlm(X,Y,'linear')

% get confidence intervals
coefCI(lm)
