% Victor Z
% UW-Madison, 2019
% compare cdfs for standard normal and normal for mixing problem

clc; clear all; close all hidden;

x=linspace(-4,4);
subplot(2,2,1)
plot(x,normcdf(x,0,1),'blue','LineWidth',1.5)
grid on
xlabel('$Q(\alpha)$','Interpreter','latex')
ylabel('$\alpha$','Interpreter','latex')
legend('$\sim{N}(0,1)$','Interpreter','latex','location','southeast')
title('')

mu=30
sig=1
x=linspace(mu-4*sig,mu+4*sig);
subplot(2,2,2)
plot(x,normcdf(x,mu,sig),'blue','LineWidth',1.5)
grid on
xlabel('$Q(\alpha)$','Interpreter','latex')
ylabel('$\alpha$','Interpreter','latex')
title('')
legend('$\sim{N}(30,1)$','Interpreter','latex','location','southeast')

print -depsc mixing_gauss.eps

% prob level
alpha=0.977

% the quantile for N(0,1)
q1 = norminv(alpha,0,1)

% the quantile of N(mu,sigma)
q2 = mu+q1*sig

% confirm this is true
q2 = norminv(alpha,mu,sig)