% Victor Z
% UW-Madison, 2019
% predict Hougen-Watson reaction using kernel method

clc; clear all; close all hidden;
format bank

S = load('reaction');
X = S.reactants; % experimental reactant concentrations
y = S.rate; % experimental reaction rates
beta = S.beta; % guess for parameters
[n,m]=size(X);

% span gamma
gamma=0.01;

for k=1:length(gamma)

% construct kernel matrix
for j=1:n
    for i=1:n
        K(i,j)=ker(X(i,:),X(j,:),gamma(k));
    end
end

% predict output 
lam=0.01;
yhat(:,k) = K*inv(K+lam*eye(n,n))*y;

SS(k)=norm(y-yhat(:,k)');

end

% plot prediction  and data
figure(1)
plot(yhat,y,'bo','MarkerFaceColor','w')
hold on
plot(y,y,'r--')
xlabel('$\hat{y}$','Interpreter','latex','Fontsize',14)
ylabel('$y$','Interpreter','latex','Fontsize',14)
grid on
print -depsc hougen_fit_kernel.eps


%%% gaussian kernel function
function f=ker(x1,x2,gam)

f = exp(-gam*norm(x1-x2));

end


