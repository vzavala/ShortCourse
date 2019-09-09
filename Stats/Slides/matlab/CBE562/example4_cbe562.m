% matlab example #4
% compute quantile of normal from std normal

clc
clear all
close all hidden

% simulate yield data plant 1
rng(0)
mu1=10; % mean
sigma1=1; % std deviation
quantile1 = norminv(0.9,mu1,sigma1)

%quantile of standard normal
q=norminv(0.9,0,1)

% get quantile using standard normal transformation
quantile2=mu1+sigma1*q


% verify confidence interval formula
alpha=0.95
zalpha2=norminv(1-alpha/2)
Pub=normcdf(mu1+zalpha2*sigma1,mu1,sigma1)
Plb=normcdf(mu1-zalpha2*sigma1,mu1,sigma1)
Pint=Pub-Plb