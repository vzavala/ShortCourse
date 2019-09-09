% Victor Z
% UW-Madison, 2019
% illustrate simple linear estimation with wrong model

clc; clear all; close all hidden; 

% generate data for input
rng(0)
S=100;
xobs=rand(S,1);

% generate true output
theta=2;
y=theta*xobs.^2;

% add noise
sigma=0.25;
eps=normrnd(0,sigma,S,1);
yobs=y+eps;

% now get estimate htheta that extracts max knowledge from data
htheta=(xobs'*yobs)/(xobs'*xobs)

% plot model prediction
ypred=htheta*xobs;

% visualize data and model prediction
figure(1)
subplot(2,2,1)
plot(xobs,yobs,'o','MarkerFaceColor','w')
hold on
grid on
plot(xobs,ypred,'-')
legend('Data','Model','location','southeast')
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')

subplot(2,2,2)
plot(yobs,ypred,'o','MarkerFaceColor','w')
axis([-0.5 3 -0.5 2.5])
hold on
grid on
plot(yobs,yobs)
axis([-0.5 2.5 -0.5 2.5])
xlabel('$y$','Interpreter','latex')
ylabel('$\hat{y}$','Interpreter','latex')

% now visualize residuals
epsm=yobs-ypred
subplot(2,2,3)
plot(epsm,'o','MarkerFaceColor','w')
axis([0,S,-2*sigma,+2*sigma])
hold on
grid on
xlabel('$\omega$','Interpreter','latex')
ylabel('$\epsilon_\omega$','Interpreter','latex')
subplot(2,2,4)
histfit(epsm)
hold on
grid on
xlabel('$\epsilon$','Interpreter','latex')
ylabel('$f(\epsilon)$','Interpreter','latex')
print -depsc results_lin_est_wrong.eps


