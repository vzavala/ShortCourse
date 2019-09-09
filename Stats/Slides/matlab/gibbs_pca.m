% Victor Z
% UW-Madison, 2019
% PCA analysis of gibbs reactor set
% https://www.mathworks.com/help/stats/pca.html

clc; clear all; close all hidden

% create data set
load cbe562gibbs_hightemp_class.dat
datahigh=cbe562gibbs_hightemp_class;
load cbe562gibbs_lowtemp_class.dat
datalow=cbe562gibbs_lowtemp_class;
data=[datahigh;datalow];
datan=data;
n=length(datan);

% corrupt data with noise to hide pattern 
rng(1); % For reproducibility 
x1 = datan(:,2)+randn(n,1)*0.1; % pressure 
x2 = datan(:,3)+randn(n,1)*0.1; % conversion
y=datan(:,1)+randn(n,1)*0.1;    % temperature
X=[y x1 x2];

% visualize the data in 2d (the clusters are hidden)
figure(1)
subplot(3,3,2)
scatter(x1,x2,'MarkerFaceColor','w')
grid on
xlabel('P')
ylabel('C')

% visualize the data in 3D (the clusters reveal)
subplot(3,3,1)
scatter3(X(:,1),X(:,2),X(:,3),'MarkerFaceColor','w')
grid on
zlabel('P')
ylabel('C')
xlabel('T')

% lets visualize the entire data in 2D using PCA 
[coeff,score,latent,~,explained,mu] = pca(X,'Algorithm','eig')

subplot(3,3,3)
scatter(score(:,1),score(:,2),'MarkerFaceColor','w')
grid on
xlabel('$t_1$','Interpreter','latex')
ylabel('$t_2$','Interpreter','latex')
print -depsc pca_gibbs.eps

% now let's try to get the eigenvectors (coeff) without using PCA 
% built-in function
% normalize original matrix and check that each column has zero mean
mun=mean(X);
Xn=X-mun;
mean(Xn)

% form covariance matrix
Sigma=Xn'*Xn

% get eigenvectors and eigenvalues from covariance matrix
[W,lam]=eigs(Sigma);
lam=diag(lam);

% get principal components and visualize
T=Xn*W;

%figure(4)
%scatter(T(:,1),T(:,2))

% now show that the principal components can be used to approximate Sigma
Sigma1 = lam(1)*W(:,1)*W(:,1)'
Sigma12 = lam(1)*W(:,1)*W(:,1)'+lam(2)*W(:,2)*W(:,2)'
Sigma123 = lam(1)*W(:,1)*W(:,1)'+lam(2)*W(:,2)*W(:,2)'+lam(3)*W(:,3)*W(:,3)'



