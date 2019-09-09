% Victor Z
% UW-Madison, 2019
% extreme value theorem

clc
clear all
close all hidden

rng(0)
N=1000;  % number of samples
subplot(2,2,1)
xgrid=linspace(2-4,2+4,1000);
plot(xgrid,normpdf(xgrid,2,1),'LineWidth',1.5)
xlabel('$x$','Interpreter','latex')
ylabel('$f(x)$','Interpreter','latex')
grid on


S=10; % sample size
for j=1:N
x = normrnd(2,1,S,1);
m(j) = max(x);
end

subplot(2,2,2)
histogram(m)
xlabel('$x_{max}$','Interpreter','latex')
ylabel('$f(x_{max})$','Interpreter','latex')
grid on
%axis([0 4 0 150])

S=100;  % number of samples
for j=1:N
x = normrnd(2,1,S,1);
m(j) = max(x);
end
subplot(2,2,3)
histogram(m)
xlabel('$x_{max}$','Interpreter','latex')
ylabel('$f(x_{max})$','Interpreter','latex')
grid on
%axis([0 4 0 150])

S=1000;  % number of samples
for j=1:N
x = normrnd(2,1,S,1);
m(j) = max(x);
end
subplot(2,2,4)
histogram(m)
xlabel('$x_{max}$','Interpreter','latex')
ylabel('$f(x_{max})$','Interpreter','latex')
grid on
%axis([0 4 0 150])

print -depsc evt_weibull.eps