% matlab example #9
% sampling normal distribution

clc
clear all
close all hidden
format short 

% specify mean and covariance 
mu = [0 0];
Sigma = [1 -0.7; -0.7 1]; % anti correlated
% Sigma = [1 0; 0 1]; % independent

% compute the 95% confidence interval ellipse
alpha = 0.95; % confidence 
n = 2; % dimension of variable
A = inv(Sigma); % inverse covariance
b = chi2inv(alpha, n); % confidence level on 2d from chi2 distribution
[xe, ye, major, minor, bbox] = ellipse(A, b, 100, mu); % ellipse

% count the number of samples in the ellipse
nsample = 1000; % number of random samples
sample = mvnrnd(mu,Sigma,nsample); % collect samples

% plot the ellipse and the samples
figure(1); hold on;
plot(xe,ye,'k') % plot ellipse
plot(sample(:,1),sample(:,2),'ro'); % plot samples
xlabel('x1'); ylabel('x2');

cnt = 0;
for i=1:nsample
    x = sample(i,:)-mu;
    if x*inv(Sigma)*x'<=b % count if in the confidence interval
        cnt=cnt+1;
    end        
end
fprintf('%i among %i samples in the ellipse\n',cnt,nsample); % print the result