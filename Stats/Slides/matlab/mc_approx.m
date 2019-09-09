% Victor Z
% UW-Madison, 2019
% show convergence of MC approximation
clc
clear all
close all hidden

rng(0)
Sv=5:5:10000;
for j=1:length(Sv)
x = wblrnd(2,1,Sv(j),1);
e(j) = mean(x);
v(j) = mean(log(x));
c(j) = var(exp(x)+x.^2);
end

subplot(3,1,1)
plot(Sv,e,'o','MarkerFaceColor','w')
xlabel('Sample Size ($S$)','Interpreter','latex')
ylabel('$E[X]$','Interpreter','latex')
grid on
subplot(3,1,2)
plot(Sv,v,'o','MarkerFaceColor','w')
xlabel('Sample Size ($S$)','Interpreter','latex')
ylabel('$E[\log(X)]$','Interpreter','latex')
grid on
subplot(3,1,3)
plot(Sv,v,'o','MarkerFaceColor','w')
xlabel('Sample Size ($S$)','Interpreter','latex')
ylabel('${V}[\exp(X)+X^2]$','Interpreter','latex')
grid on

print -depsc convergence_mc.eps