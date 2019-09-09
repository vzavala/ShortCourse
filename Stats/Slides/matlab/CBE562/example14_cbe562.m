% matlab example #14 - nonlinear regression in matlab
% https://www.mathworks.com/help/stats/rsmdemo.html

clc
clear all
close all hidden

S = load('reaction');
X = S.reactants % reactant concentrations
y = S.rate % reaction rates
beta0 = S.beta % initial guess for parameters

myfun = 'y~(b1*x2-x3/b5)/(1+b2*x1+b3*x2+b4*x3)';

opts = statset('Display','iter','TolFun',1e-10);
nlm = fitnlm(X,y,myfun,beta0,'Options',opts)

coefCI(nlm)