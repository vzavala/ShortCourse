%clustering analysis of gibbs set
%https://www.mathworks.com/help/stats/pca.html

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
        datan(i,1)=0; % control failure
    end
end

% corrupt data with noise to hide pattern (as we increase noise, confusion
% increases)
rng(1); % For reproducibility 
x1 = datan(:,2)+randn(n,1)*0.1;
x2 = datan(:,3)+randn(n,1)*0.1;
y=datan(:,1);
X=[y,x1 x2];

% visualize the data
figure(1); hold on;
h1 = scatter(x1(y==0),x2(y==0),50,'k','filled');  % black dots for 0
h2 = scatter(x1(y==1),x2(y==1),50,'w','filled');  % white dots for 1
set([h1 h2],'MarkerEdgeColor',[.5 .5 .5]);        % outline dots in gray
legend([h1 h2],{'y=0 (Control Failure)' 'y=1 (Control Normal)'},'Location','NorthEastOutside');
xlabel('P');
ylabel('Conversion');

% try to identify clusters using k-means
% first normalize data (important)
X=normalize(X);
k=2 % number of clusters
[idx,C] = kmeans(X,k,'Distance','sqeuclidean')

% compare
figure(2); hold on;
h1 = scatter(x1(idx==1),x2(idx==1),50,'k','filled');  % black dots for 0
h2 = scatter(x1(idx==2),x2(idx==2),50,'w','filled');  % white dots for 1
set([h1 h2],'MarkerEdgeColor',[.5 .5 .5]);        % outline dots in gray
legend([h1 h2],{'Cluster 1' 'Cluster 2'},'Location','NorthEastOutside');
xlabel('P');
ylabel('Conversion');

% compare true label and cluster 
[idx,y]


