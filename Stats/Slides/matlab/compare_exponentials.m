% Victor Z
% UW-Madison, 2019
% compare exponentials

clc; clear all; close all hidden;

beta=[1,2,4];
color=["blue","red","green"];
x=linspace(0,4,1000);

subplot(2,2,1)
for k=1:length(beta)
plot(x,exppdf(x,beta(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
xlabel('$x$','Interpreter','latex')
ylabel('$f(x)$','Interpreter','latex')
title('')

subplot(2,2,2)
for k=1:length(beta)
plot(x,expcdf(x,beta(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
lgd=legend('$\beta=1$','$\beta=2$','$\beta=4$','Interpreter','latex','location','southeast')
lgd.FontSize = 8;
xlabel('$x$','Interpreter','latex')
ylabel('$F(x)$','Interpreter','latex')
title('')
print -depsc exponentials.eps
