%logistic classification for gibbs data
%https://www.mathworks.com/help/stats/fitclinear.html#bu5mw4p

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
x1 = datan(:,2)+randn(n,1)*0.01;
x2 = datan(:,3)+randn(n,1)*0.01;
y=datan(:,1);
X=[x1 x2];

% visualize the data
figure(1); hold on;
h1 = scatter(x1(y==0),x2(y==0),50,'k','filled');  % black dots for 0
h2 = scatter(x1(y==1),x2(y==1),50,'w','filled');  % white dots for 1
set([h1 h2],'MarkerEdgeColor',[.5 .5 .5]);        % outline dots in gray
legend([h1 h2],{'y=0 (Control Failure)' 'y=1 (Control Normal)'},'Location','NorthEastOutside');
xlabel('P');
ylabel('Conversion');

% train model
rng(1); % For reproducibility 
[Mdl,FitInfo] = fitclinear(X,y,'Learner','logistic');

% predict
[ypred,Score] = predict(Mdl,X)
% Score indicates probability that the i-th prediction is in either class

% visualize the predictions
figure(3); hold on;
h1 = scatter(x1(ypred==0),x2(ypred==0),50,'k','filled');  % black dots for 0
h2 = scatter(x1(ypred==1),x2(ypred==1),50,'w','filled');  % white dots for 1
set([h1 h2],'MarkerEdgeColor',[.5 .5 .5]);        % outline dots in gray
legend([h1 h2],{'ypred=0 (Control Failure)' 'ypred=1 (Control Normal)'},'Location','NorthEastOutside');
xlabel('P');
ylabel('Conversion');

% confusion matrix
figure(4)
ConfusionTrain = confusionchart(y,ypred);

%%% splitting data set into train and test
Ystats=y;
CVMdl = fitclinear(X,Ystats,'Learner','logistic','Holdout',0.40);
Mdl = CVMdl.Trained{1};

trainIdx = training(CVMdl.Partition);
testIdx = test(CVMdl.Partition);
labelTrain = predict(Mdl,X(trainIdx,:));
labelTest = predict(Mdl,X(testIdx,:));

%Construct a confusion matrix for the training data.
figure(5)
ConfusionTrain = confusionchart(Ystats(trainIdx),labelTrain);

%Construct a confusion matrix for the test data.
figure(6)
ConfusionTest = confusionchart(Ystats(testIdx),labelTest);
