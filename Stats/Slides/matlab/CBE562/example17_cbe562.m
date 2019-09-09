%SVM classification for gibbs data
%https://www.mathworks.com/help/stats/fitclinear.html#bu5mw4p
%https://www.mathworks.com/help/stats/fitcsvm.html

clc
clear all
close all hidden

% create data set
load cbe562gibbs_hightemp_class.dat
datahigh=cbe562gibbs_hightemp_class;
load cbe562gibbs_lowtemp_class.dat
datalow=cbe562gibbs_lowtemp_class;
data=[datahigh;datalow];
datan=data;
n=length(datan);
for i=1:n
    if datan(i,1)==583.15
        datan(i,1)=1; % control normal
    else
        datan(i,1)=-1; % control failure
    end
end

% corrupt data with noise to hide pattern (as we increase noise, confusion
% increases)
rng(1); % For reproducibility 
x1 = datan(1:n,2)+randn(n,1)*0.05;
x2 = datan(1:n,3)+randn(n,1)*0.05;
y=datan(1:n,1);
X=[x1 x2];

% learn model using fitcsvm function
SVMModel = fitcsvm(X,y,'Solver','L1QP','BoxConstraint',1); % fit
[ypred,Score] = predict(SVMModel,X); % predict

sv = SVMModel.SupportVectors;

% visualize the predictions
figure(1); hold on;
h1 = scatter(x1(ypred==-1),x2(ypred==-1),50,'k','filled');  % black dots for 0
h2 = scatter(x1(ypred==1),x2(ypred==1),50,'w','filled');  % white dots for 1
set([h1 h2],'MarkerEdgeColor',[.5 .5 .5]);        % outline dots in gray
h3=plot(sv(:,1),sv(:,2),'ro','MarkerSize',10)
legend([h1 h2 h3],{'ypred=-1 (Control Failure)' 'ypred=+1 (Control Normal)','Support Vectors'},'Location','NorthEastOutside');
xlabel('P');
ylabel('Conversion');

figure(2)
ConfusionTrain = confusionchart(y,ypred);


% display coefficients
SVMModel.Beta
SVMModel.Bias

% now assemble QP (min (1/2)*x'*H*x + f'*x   subject to:  A*x <= b)
% Assume variable vector of the form x=[w,b,xi]
C=1;              % regularization parameter
nv=n+3;           % total number of variables

% assemble gradient
f=[zeros(2,1); zeros(1,1); C*ones(n,1)];

% assemble H matrix
H=zeros(nv,nv);
H(1:2,1:2)=eye(2,2);
H=sparse(H);

% assemble constraint matrix
A=zeros(n,nv);
for i=1:n
    yi=y(i);
    xi=X(i,:);
    e=zeros(n,1);
    e(i)=1;
    A(i,:)=[yi*xi yi e'];
end
A=-sparse(A);

% assemble right-hand side
b=-ones(n,1);

% construct lb and ub
ub=ones(nv,1)*(+Inf);
lb=ones(nv,1)*(-Inf);
lb(4:nv)=0;

% solve
sol = quadprog(H,f,A,b,[],[],lb,ub);

% get svm coefficients
beta=sol(1:2)
b=sol(3)

% get predictions
for i=1:n
    xi=X(i,:);
    ypred(i)=sign(xi*beta+b);
end

