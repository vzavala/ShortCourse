% matlab example #6
% get covariance and correlation matrix for gibbs reactor

clc
clear all
close all hidden
format short 

load cbe562gibbs_covariance.dat
data=cbe562gibbs_covariance;

% data order (pressure, extent, flow co, flow h2, flow ch3oh)

% get covariance matrix
C=cov(data)

% get correlation matrix
R=corrcov(C)

% get eigenvalues of covariance matrix
lambda=eigs(C)

figure(1)
subplot(2,2,1)
plot(data(:,1),data(:,2),'o')
xlabel('Pressure')
ylabel('Extent')
subplot(2,2,2)
plot(data(:,1),data(:,3),'o')
xlabel('Pressure')
ylabel('Flow CO')

% visualize (P vs extent) in 2-d
figure(2)
hist3(data(:,1:2),'CDataMode','auto','FaceColor','interp')
xlabel('Pressure [bar]')
ylabel('Extent [kmol/hr]')
zlabel('Frequency')

% visualize (P vs flow co) in 2-d
figure(3)
X=[data(:,1) data(:,3)]
hist3(X,'CDataMode','auto','FaceColor','interp')
xlabel('Pressure [bar]')
ylabel('CO Flow [kmol/hr]')
zlabel('Frequency')

