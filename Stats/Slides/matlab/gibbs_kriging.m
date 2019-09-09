% Victor Z
% UW-Madison, 2019
% Gaussian process (kriging) prediction for gibbs data
% https://www.mathworks.com/help/stats/fitrgp.html
% https://www.mathworks.com/help/stats/compactregressiongp.predict.html

clc
clear all
close all hidden

% create data set
load cbe562gibbs_hightemp_class.dat
datahigh=cbe562gibbs_hightemp_class;
load cbe562gibbs_lowtemp_class.dat
datalow=cbe562gibbs_lowtemp_class;
data=[datahigh;datalow];
n=length(data);

rng(0)
inputs=data(:,1:2)'+rand(2,n)*0.1; % temperature and pressure
targets=data(:,3)'+rand(1,n)*0.1;   % yield

gprMdl = fitrgp(inputs',targets','KernelFunction','squaredexponential')
[outputsgpr,outputsd,outputsci] = predict(gprMdl,inputs');
eps=targets'-outputsgpr;

% plot fit
figure(1)
subplot(2,2,1)
xx=linspace(0,1.1)
plot(targets,outputsgpr,'o','MarkerFaceColor','w')
grid on
hold on
plot(xx,xx,'black-')
xlabel('$y$','Interpreter','latex','FontSize',14)
ylabel('$\hat{y}$','Interpreter','latex','FontSize',14)
legend('Kriging','Location','southeast')
axis([0,1.1,0,1.1])

% compare against linear regression model
mdl = fitlm(inputs',targets')
outputsLR = predict(mdl,inputs');
eps2=targets'-outputsLR;

figure(1)
subplot(2,2,2)
plot(targets,outputsLR,'o','MarkerFaceColor','w')
hold on
grid on
plot(xx,xx,'black-')
xlabel('$y$','Interpreter','latex','FontSize',14)
ylabel('$\hat{y}$','Interpreter','latex','FontSize',14)
axis([0,1.1,0,1.1])
legend('Linear','Location','southeast')
print -depsc fit_gibbs_kriging_linear.eps

% compare benchmark using cdfs of residuals
figure(3)
[F1,X1]=ecdf(abs(eps));
[F2,X2]=ecdf(abs(eps2));
stairs(X1,F1,'-','LineWidth',1.5)
hold on
stairs(X2,F2,'-','LineWidth',1.5)
grid on
axis([0,0.1,0,1.01])
xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$P(\epsilon\leq t)$','Interpreter','latex','FontSize',14)
legend('Kriging','Linear','Location','southeast')
print -depsc benchmark_gibbs_kriging_linear.eps

% compare benchmark using cdfs of residuals
figure(4)
subplot(2,2,1)
hist(abs(eps))
legend('Kriging','Location','northeast')
grid on
xlabel('$t$','Interpreter','latex')
ylabel('$S\times P(\epsilon=t)$','Interpreter','latex')
axis([0 0.1 0 120])
subplot(2,2,2)
hist(abs(eps2))
legend('Linear','Location','northeast')
grid on
xlabel('$t$','Interpreter','latex','FontSize',14)
ylabel('$S\times P(\epsilon=t)$','Interpreter','latex','FontSize',14)
axis([0 0.1 0 120])
print -depsc benchmark_gibbs_kriging_linear_pdf.eps

% plot confidence intervals for gpr
c1=outputsci(:,1);
c2=outputsci(:,2);
figure(2)
plot(targets(1:100),'r');
hold on;
plot(outputsgpr(1:100),'b');
plot(c1(1:100),'k:');
plot(c2(1:100),'k:');
xlabel('Observation $\omega$','Interpreter','latex','FontSize',14)
ylabel('Output $y$','Interpreter','latex','FontSize',14)
grid on
legend('True','Model','95% lower','95% upper','Location','Southwest');
print -depsc conf_gibbs.eps

