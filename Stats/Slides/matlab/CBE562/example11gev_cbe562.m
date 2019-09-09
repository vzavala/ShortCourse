% matlab example #11
% illustrate central limit theorem

clc
clear all
close all hidden
format short 

% assume underlying distribution is Weibull
N = 1000;
R = wblrnd(1,2,N,1); 
%figure(1)
%histfit(R,20,'wbl')
%trumean=mean(R)

% draw Ns samples from Exponential and compute mean 
% repeat Nt times and plot histogram of mean estimates
Nsv=[2,5,10,100]
 Nt=1000
for i=1:length(Nsv)
    Ns=Nsv(i)
for j=1:Nt
muest(j) = max(wblrnd(1,2,Ns,1)); 
end

figure(2)
subplot(2,2,i)
histfit(muest,20,'gev')

end


% now assume underlying distribution is exponential
%figure(3)
R = normrnd(10,1,N,1); 
%histfit(R,20,'exp')
%trumean=mean(R)

% draw Ns samples from Exponential and compute mean 
% repeat Nt times and plot histogram of mean estimates
for i=1:length(Nsv)
    Ns=Nsv(i)
for j=1:Nt
muest(j) = max(normrnd(10,1,Ns,1)); 
end

figure(4)
subplot(2,2,i)
histfit(muest,20,'gev')

end
