% Victor Z
% UW-Madison, 2019
% random and biased samples

clc
clear all
close all hidden

% generate observations for exponential
rng(0)
S = 100;
x = normrnd(0,1,S,1);
xx=1:1:S;

for k=1:S
x2(k) = max(normrnd(0,1,S,1));
end

% generate sample plot
mx=linspace(mean(x),mean(x),S);
mx2=linspace(mean(x2),mean(x2),S);

figure(1)
subplot(2,1,1)
plot(xx,mx,'black','LineWidth',1.5)
hold on
plot(x,'o','MarkerSize',3)
grid on
xlabel('\omega')
ylabel('x_\omega')
subplot(2,1,2)
plot(xx,mx2,'black','LineWidth',1.5)
hold on
plot(xx,x2,'o','MarkerSize',3)
grid on
xlabel('\omega')
ylabel('x_\omega')
print -depsc random_sample.eps