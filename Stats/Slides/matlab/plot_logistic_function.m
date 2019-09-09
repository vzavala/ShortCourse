% Victor Z
% UW-Madison, 2019
% visualize logistic function

clc; clear all; close all hidden;

% span parameter
theta=[-1,0,1];

% span x space
x = linspace(-5,5);

for k=1:length(theta)
    theta(k)
    y=1./(1+exp(-theta(k)*x));
    figure(1)
    plot(x,y,'LineWidth',1.5);
    hold on
end
grid on
legend('$\theta=-1$','$\theta=0$', '$\theta=+1$','Interpreter','latex','location','southeast')
xlabel('$x$','Interpreter','latex')
ylabel('$g(x,\theta)$','Interpreter','latex')
print -depsc logistic.eps

