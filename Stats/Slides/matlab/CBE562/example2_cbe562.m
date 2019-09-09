% matlab example #2
% illustration histograms, density function, and comparison of random
% variables

clc
clear all
close all hidden

% simulate yield data plant 1
rng(0)
mu1=10; % mean
sigma1=1; % std deviation
N=100; % number of samples
data1=normrnd(mu1,sigma1,N,1)

% compute profit
data2= 50+(10-data1).^2

mean_profit=mean(data2)
stddev_profit=std(data2)

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

