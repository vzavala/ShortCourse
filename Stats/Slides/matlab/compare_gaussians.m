% Victor Z
% UW-Madison, 2019
% compare gaussians

clc; clear all; close all hidden;

mu=[0,0,0,1];
sigma=[sqrt(1/5),sqrt(1),sqrt(4),sqrt(1/10)];
color=["blue","red","green","black"];
x=linspace(-5,5,1000);

subplot(2,2,1)
for k=1:length(mu)
plot(x,normpdf(x,mu(k),sigma(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
xlabel('$x$','Interpreter','latex')
ylabel('$f(x)$','Interpreter','latex')
title('')

subplot(2,2,2)
for k=1:length(mu)
plot(x,normcdf(x,mu(k),sigma(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
lgd=legend('$\mu=0,\sigma=0.2$','$\mu=0,\sigma=1$','$\mu=0,\sigma=4$','$\mu=1,\sigma=0.1$','Interpreter','latex','location','southeast')
lgd.FontSize = 8;
xlabel('$x$','Interpreter','latex')
ylabel('$F(x)$','Interpreter','latex')
title('')
print -depsc gaussians.eps
