% Victor Z
% UW-Madison, 2019
% gibbs reactor example

clc; clear all; close all hidden;

% load data
load cbe562gibbs_hightemp.dat
datahigh=cbe562gibbs_hightemp;
load cbe562gibbs_lowtemp.dat
datalow=cbe562gibbs_lowtemp;

% compare pdf and cdf of pressure

figure(1)

subplot(3,1,1)
plot(datahigh(:,1),'.')
xlabel('Outcome $\omega$','Interpreter','latex')
ylabel('$x_\omega$ [bar]','Interpreter','latex')
grid on

subplot(3,1,2)
histogram(datahigh(:,1))
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('$S\times {P}(X=x)$','Interpreter','latex')
grid on

figure(1)
subplot(3,1,3)
cdfplot(datahigh(:,1))
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('${P}(X\leq x)$','Interpreter','latex')
title('')
print -depsc gibbs_press_pdf_cdf.eps

% show empirical and theoretical pdf/cdf
% get theoretical pdf from data
param = fitdist(datahigh(:,1),'normal')

figure(2)

subplot(2,1,1)
histfit(datahigh(:,1))
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('$S\times {P}(X=x)$','Interpreter','latex')
grid on
legend('Empirical','Theoretical')

subplot(2,1,2)
ecdf(datahigh(:,1))
x=linspace(60,240);
hold on
plot(x,normcdf(x,param.mu,param.sigma),'red')
grid on
legend('Empirical','Theoretical','Location','southeast')
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('${P}(X\leq x)$','Interpreter','latex')
title('')
print -depsc gibbs_press_pdf_cdf_fit.eps


% show convergence of sample approximations
figure(3)
dataP=datahigh(:,1);
Sv=5:5:1000;
for j=1:length(Sv)
y = datasample(dataP,Sv(j));
e(j) = mean(y);
v(j) = sqrt(var(y));
end
et=linspace(param.mu,param.mu,length(Sv));
vt=linspace(param.sigma,param.sigma,length(Sv))

subplot(2,1,1)
plot(Sv,e,'o','MarkerFaceColor','w')
hold on
plot(Sv,et,'r-')
xlabel('Sample Size ($S$)','Interpreter','latex')
ylabel('$E[X]$','Interpreter','latex')
grid on

subplot(2,1,2)
plot(Sv,v,'o','MarkerFaceColor','w')
hold on
plot(Sv,vt,'r-')
xlabel('Sample Size ($S$)','Interpreter','latex')
ylabel('$SD[X]$','Interpreter','latex')
grid on

print -depsc gibbs_press_exp_var.eps

% get sample moments and quantile
m1=moment(dataP,1)
m2=moment(dataP,2)
m3=moment(dataP,3)
m4=moment(dataP,4)

figure(4)
yy1=linspace(0.5,0.5,100);
xx1=linspace(quantile(dataP,0.5),quantile(dataP,0.5));
yy2=linspace(0.9,0.9,100);
xx2=linspace(quantile(dataP,0.9),quantile(dataP,0.9));
xx=linspace(60,240);
yy=linspace(0,1);
ecdf(dataP)
hold on
plot(x,normcdf(x,param.mu,param.sigma),'red')
plot(xx,yy1,'black--')
hold on
plot(xx1,yy,'black--')
hold on
plot(xx,yy2,'black--')
hold on
plot(xx2,yy,'black--')
grid on
xlabel('$x=Q(\alpha)$ [bar]','Interpreter','latex')
ylabel('$\alpha={P}(X\leq x)$','Interpreter','latex')
title('')
print -depsc gibbs_press_quantile.eps


% compare pressure and extent at high temperature

figure(4)

subplot(2,2,1)
histogram(datahigh(:,1))
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('$S\times {P}(X=x)$','Interpreter','latex')
grid on

subplot(2,2,2)
ecdf(datahigh(:,1))
x=linspace(60,240);
grid on
xlabel('$x$ [bar]','Interpreter','latex')
ylabel('${P}(X\leq x)$','Interpreter','latex')
title('')

subplot(2,2,3)
histogram(100*datahigh(:,2))
xlabel('$y$ [\%]','Interpreter','latex')
ylabel('$S\times {P}(Y=y)$','Interpreter','latex')
grid on

subplot(2,2,4)
ecdf(100*datahigh(:,2))
%x=linspace(60,240);
grid on
xlabel('$y$ [\%]','Interpreter','latex')
ylabel('${P}(Y\leq y)$','Interpreter','latex')
title('')
print -depsc gibbs_press_extent.eps

% compare extent at low and high temperature

figure(5)

subplot(2,2,1)
histogram(100*datalow(:,2))
hold on
histogram(100*datahigh(:,2))
xlabel('$y$ [\%]','Interpreter','latex')
ylabel('$S\times {P}(Y=y)$','Interpreter','latex')
grid on
legend('Low T','High T','Location','northwest')

subplot(2,2,2)
ecdf(100*datalow(:,2))
hold on
ecdf(100*datahigh(:,2))
grid on
legend('Low T','High T','Location','northwest')
xlabel('$y$ [\%]','Interpreter','latex')
ylabel('${P}(Y\leq y)$','Interpreter','latex')
title('')

print -depsc gibbs_extent_temp.eps
