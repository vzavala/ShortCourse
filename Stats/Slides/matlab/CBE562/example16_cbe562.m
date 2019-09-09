%NN prediction for gibbs data
%https://www.mathworks.com/help/deeplearning/gs/fit-data-with-a-neural-network.html#f9-33554

clc
clear all
close all hidden

% create data set
load cbe562gibbs_hightemp_class.dat
datahigh=cbe562gibbs_hightemp_class;
load cbe562gibbs_lowtemp_class.dat
datalow=cbe562gibbs_lowtemp_class;
data=[datahigh;datalow];
n=length(data);

inputs=data(:,1:2)'+rand(2,n)*0.1; % temperature and pressure
targets=data(:,3)'+rand(1,n)*0.1;   % yield

% construct network
% The default network for function fitting (or regression) problems, fitnet
% is a feedforward network with the default tan-sigmoid transfer function 
% in the hidden layer and linear transfer function in the output layer. 
% The network has one output neuron, because there is only one target value associated with each input vector.

hiddenLayerSize = 2;
net = fitnet(hiddenLayerSize);

net.divideParam.trainRatio = 1.0;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

[net, tr] = train(net, inputs, targets);

outputs = net(inputs);
errors = gsubtract(targets, outputs);
performance = perform(net, targets, outputs)

% construct regression plot
figure(1)
plotregression(targets,outputs,'Regression')

% compare against linear regression model
mdl = fitlm(inputs',targets')
outputsLR = predict(mdl,inputs');

figure(2)
plotregression(targets,outputsLR,'Regression')

figure(3)
plotResiduals(mdl,'probability')
