% Victor Z
% UW-Madison, 2019
% MLE for exponential RV

clc
clear all
close all hidden

% generate observations for weibull
rng(0)
S = 1000;
x = exprnd(2,S,1);

% plot log likelihood
beta=linspace(0,10,100)
ss=sum(x)
logL=-S*log(beta)-(1./beta)*ss

figure(1)
plot(beta,logL,'blue-','LineWidth',1.5)
xlabel('$\beta$','Interpreter','latex'); 
ylabel('$\log L(\beta)$','Interpreter','latex'); 
grid on
axis([0,10,-3e3, -1.6e3])
print -depsc loglike_exp.eps