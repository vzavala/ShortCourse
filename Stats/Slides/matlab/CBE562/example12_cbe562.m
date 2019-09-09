% matlab example #12 - fitting gibbs reactor to Normal and Weibull

clc
clear all
close all hidden

load cbe562gibbs_lowtemp.dat
datalow=cbe562gibbs_lowtemp;
data=datalow(:,2); 
n=length(data);
extent=data(1:n/20)

% first visualize data
figure(1)
subplot(2,1,1)
histogram(extent)
xlabel('Extent [kmol/hr]')
ylabel('Frequency')


% try fitting to Gaussian
figure(1)
subplot(2,1,1)
histfit(extent,20,'Normal')
xlabel('Extent [kmol/hr]')
ylabel('Frequency')

% get  parameters

[param,confint] = mle(extent,'distribution','Normal')

% try fiting to weibull
figure(2)
subplot(2,1,1)
histfit(extent,20,'weibull')
xlabel('Extent [kmol/hr]')
ylabel('Frequency')

% get  parameters and confidence intervals

[param,confint] = mle(extent,'distribution','Weibull')
