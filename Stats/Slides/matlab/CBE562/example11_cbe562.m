% matlab example #11
% illustrate central limit theorem

clc
clear all
close all hidden
format short 

% assume underlying distribution is Weibull
N = 1000;
R = wblrnd(1,2,N,1); 
figure(1)
histfit(R,20,'wbl')
trumean=mean(R)

% draw Ns samples from Exponential and compute mean 
% repeat Nt times and plot histogram of mean estimates
Nsv=[2,5,10,100]
 Nt=1000
for i=1:length(Nsv)
    Ns=Nsv(i)
for j=1:Nt
muest(j) = mean(wblrnd(1,2,Ns,1)); 
end

figure(2)
subplot(2,2,i)
histfit(muest,20,'Normal')
estmean=mean(muest)

end

% now assume underlying distribution is exponential
figure(3)
R = exprnd(10,N,1); 
histfit(R,20,'exp')
trumean=mean(R)

% draw Ns samples from Exponential and compute mean 
% repeat Nt times and plot histogram of mean estimates
for i=1:length(Nsv)
    Ns=Nsv(i)
for j=1:Nt
muest(j) = mean(exprnd(10,Ns,1)); 
end

figure(4)
subplot(2,2,i)
histfit(muest,20,'Normal')
estmean=mean(muest)

end
