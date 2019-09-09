% matlab example #3
% random variable transformation

clc
clear all
close all hidden

% simulate yield data plant 1
rng(0)
mu1=10; % mean
sigma1=1; % std deviation
N=1000; % number of samples
data1=normrnd(mu1,sigma1,N,1)

% compute profit
data2= 10+20*data1
mu2=10+20*mu1
sigma2=20*sigma1

% plot data 1 as histogram & cdf
figure(1)
subplot(1,2,1)
histfit(data1)
grid on
xlabel('Outcome x')
ylabel('100 x f(x)=P(X=x)')
title('Yield')

% plot data 2 as histogram & cdf
subplot(1,2,2)
histfit(data2)
grid on
xlabel('Outcome x')
ylabel('100 x f(x)=P(X=x)')
title('Profit')

mean(data1)
mean(data2)

var(data1)
var(data2)

% plot data 1 as histogram & cdf
figure(2)
subplot(1,2,1)
cdfplot(data1)
grid on
xlabel('Outcome x')
ylabel('100 x f(x)=P(X=x)')
title('Yield')

% plot data 2 as histogram & cdf
subplot(1,2,2)
cdfplot(data2)
grid on
xlabel('Outcome x')
ylabel('100 x f(x)=P(X=x)')
title('Profit')

%confirm quantiles
quantile1 = norminv(0.841,mu1,sigma1)
quantile2 = norminv(0.841,mu2,sigma2)