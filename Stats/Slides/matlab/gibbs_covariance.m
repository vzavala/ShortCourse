% Victor Z
% UW-Madison, 2019
% covariance and correlation matrix for gibbs reactor

clc; clear all; close all hidden;
format bank 

% data order (pressure, extent, flow co, flow h2, flow ch3oh)
load cbe562gibbs_covariance.dat
data1=cbe562gibbs_covariance;

% normalize data 
data1=normalize(data1,1);

% perturb data with noise
data=data1+normrnd(0,0.5,250,5);

% get covariance matrix
C=cov(data)

% get correlation matrix
R=corrcov(C)

% get eigenvalues of covariance matrix
lambda=eigs(C)

figure(1)
subplot(2,2,1)
plot(data(:,1),data(:,2),'o','MarkerFacecolor','w')
xlabel('Pressure')
ylabel('Conversion')
grid on
subplot(2,2,2)
plot(data(:,1),data(:,3),'o','MarkerFacecolor','w')
xlabel('Pressure')
ylabel('Flow CO')
grid on
subplot(2,2,3)
plot(data(:,3),data(:,4),'o','MarkerFacecolor','w')
ylabel('Flow H2')
xlabel('Flow CO')
grid on
subplot(2,2,4)
plot(data(:,4),data(:,5),'o','MarkerFacecolor','w')
ylabel('Flow CH3OH')
xlabel('Flow H2')
grid on
print -depsc correlation_gibbs.eps



