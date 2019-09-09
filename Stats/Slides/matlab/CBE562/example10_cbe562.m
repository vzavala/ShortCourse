% matlab example #10
% show convergence of sample mean to expected value (law of large numbers)

clc
clear all
close all hidden
format short 

mu=10 % true mean
sigma=10; % std deviation 
rng(0)

% check behavior with 10 samples (try 5 times)
N=1000; % number of samples
Nt=5; % number of trials
for j=1:Nt
muest(j)=mean(normrnd(mu,sigma,N,1));
end

% display estimate at different trials
muest

% visualize as bloxplot (shows median and 25,75% quantiles)
figure(1)
boxplot(muest)
xlabel('Index')
ylabel('Estimate')

% now lets try this for different number of samples

Nv=[10, 100, 1000]; % number of samples
Nt=5; % number of trials
for i=1:length(Nv)
    N=Nv(i);
	for j=1:Nt
    muestn(j,i)=mean(normrnd(mu,sigma,N,1));
    end
end

muestn

% visualize as bloxplot (shows median and 25,75% quantiles)
figure(2)
boxplot(muestn)
hold on
xlabel('Index')
ylabel('Estimate')
