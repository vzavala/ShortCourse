% Victor Z
% UW-Madison, 2019
% compare weibull

clc; clear all; close all hidden;

 beta=[1,1,2,2];
   xi=[1,2,1,2];
color=["blue","red","green","black"];
x=linspace(0,4,1000);

subplot(2,2,1)
for k=1:length(beta)
plot(x,wblpdf(x,beta(k),xi(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
xlabel('$x$','Interpreter','latex')
ylabel('$f(x)$','Interpreter','latex')
title('')

subplot(2,2,2)
for k=1:length(beta)
plot(x,wblcdf(x,beta(k),xi(k)),color(k),'LineWidth',1.5)
hold on
end
grid on
lgd=legend('$\beta=1,\xi=1$','$\beta=1,\xi=2$','$\beta=2,\xi=1$','$\beta=2,\xi=2$','Interpreter','latex','location','southeast')
lgd.FontSize = 8;
xlabel('$x$','Interpreter','latex')
ylabel('$F(x)$','Interpreter','latex')
title('')
print -depsc weibull.eps
