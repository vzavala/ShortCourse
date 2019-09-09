% matlab example #7
% multidimensional Gaussians

clc
clear all
close all hidden
format short 

% specify mean and covariance 
mu = [1 0];
%Sigma = [1 -0.7; -0.7 1]; % anti correlated
Sigma = [1 0; 0 1]; % independent

% evaluate probability density function in domain(-3,3 and -3,3)
x1 = linspace(-3,3); x2 = linspace(-3,3);
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);

% visualize
figure(1)
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-3 3 -3 3 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

% see countours at different probabilities
figure(2)
contour(x1,x2,F,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);
xlabel('x1'); ylabel('x2');

% now plot cdf
figure(3)
p = mvncdf([X1(:) X2(:)],mu,Sigma);
p = reshape(p,length(x2),length(x1));
surf(x1,x2,p);
xlabel('x1'); ylabel('x2'); zlabel('Cumulative Density');

% calculate probability that (1<=x1<=2 & 0.5<=x2<=1)
[F,err] = mvncdf([1 0.5],[2 1],mu,Sigma)

