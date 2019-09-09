% Victor Z
% UW-Madison, 2019
% least-squares fit of weibull

clc
clear all
close all hidden

% generate observations for weibull
rng(0)
n = 1000;
x = wblrnd(2,1,n,1);

% generate thresholds and ecdf at thresholds
N = 20;
t = linspace(min(x),max(x),N);

for k=1:length(t)
   s=0;
   for j=1:n
       if x(j)<=t(k)
           s=s+1
       end
   end
   F(k)=(1/n)*s;
end

% drop last term
t=t(1:N-1)
F=F(1:N-1)

% solve least-squares problem
 y = log(t);
 x = log(-log(1 - F));
 poly = polyfit(x,y,1);
 theta = [exp(poly(2)) 1/poly(1)]
 
figure(1)
tgrid=linspace(0,max(t),100)
plot(t,F,'blueo','MarkerFaceColor','w')
hold on
plot(tgrid,wblcdf(tgrid,2,1),'b-');
hold on
plot(tgrid,wblcdf(tgrid,theta(1),theta(2)),'r--');
xlabel('t'); ylabel('F(t)');
grid on
legend({'Empirical','Theoretical','Least-Squares'},'location','southeast');
print -depsc lsfit_weibull.eps