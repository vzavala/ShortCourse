%Gaussian process (kriging) prediction for gibbs data
%https://www.mathworks.com/help/stats/fitrgp.html
%https://www.mathworks.com/help/stats/compactregressiongp.predict.html

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

gprMdl = fitrgp(inputs',targets','KernelFunction','squaredexponential')
[outputsgpr,outputsd,outputsci] = predict(gprMdl,inputs');

figure(1)
plotregression(targets,outputsgpr,'Regression')

figure(2)
plot(targets,'r');
hold on;
plot(outputsgpr,'b');
plot(outputsci(:,1),'k:');
plot(outputsci(:,2),'k:');
xlabel('Data Point')
ylabel('Output')

legend('Actual response','GPR predictions',...
'95% lower','95% upper','Location','Best');