%clustering analysis of gibbs set
%https://www.mathworks.com/help/stats/pca.html

clc
clear all
close all hidden

% compare investment strategies
rng(0)
N=1000;
ir=exprnd(0.2,N,1);

figure(1)
histogram(ir,'Normalization','probability')
xlabel('Interest Rate')
ylabel('Frequency') 

% evaluate investment 1
C1=100;
ROI1=0.3;
for i=1:N
    NPV1(i) = -C1 + ROI1*C1*(1-(1+ir(i))^(-10))/ir(i);
end
NPV1=-NPV1;

% evaluate investment 2
C2=1000;
ROI2=0.2;
for i=1:N
    NPV2(i)=-C2 + ROI2*C2*(1-(1+ir(i))^(-10))/ir(i);
end
NPV2=-NPV2;

% lets compare pdfs of NPV
figure(2)
histogram(NPV1,'Normalization','probability')
xlabel('NPV')
ylabel('Probability') 
hold on
histogram(NPV2,'Normalization','probability')
legend('Investment 1', 'Investment 2')

% lets compare cdfs of NPV
figure(3)
cdfplot(NPV1)
xlabel('NPV')
ylabel('Probability') 
hold on
cdfplot(NPV2)
legend('Investment 1', 'Investment 2')
xlabel('t')
ylabel('F(t)')
title('')

% get worse case
WC1=max(NPV1)
WC2=max(NPV2)

% get expected value
EV1=mean(NPV1)
EV2=mean(NPV2)


