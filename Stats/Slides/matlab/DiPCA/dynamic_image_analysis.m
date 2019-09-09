% Victor Z
% UW-Madison, 2019
% dynamic principal component analysis

clear;close all; clc

ndataset=1 %(up to 30)
for i=1:1 % for each data set
    fprintf('* data %i \n',i)
    
    % import the video into time-series array
    [X_water,Width_water,Height_water] = avi2arr(sprintf('data/water-%i.avi',i));
    [X_dmmp,Width_dmmp,Height_dmmp] = avi2arr(sprintf('data/dmmp-%i.avi',i));

    % make the data mean zero
    mn_water = mean(X_water,1);
    mn_dmmp = mean(X_dmmp,1);    
    X_water = X_water - mn_water;
    X_dmmp = X_dmmp - mn_dmmp;

    % run DiPCA with s=4 and 2 principal components.
    fprintf('** solving DiPCA for water\n',i)
    [w_water,b_water] = DiPCA(X_water,4,2);
    fprintf('** solving DiPCA for dmmp\n',i)
    [w_dmmp,b_dmmp] = DiPCA(X_dmmp,4,2);

    % convert the first eigenvector into image
    x_water = w_water(:,1) + min(w_water(:,1)); x_water = x_water/max(x_water);
    arr2img(sprintf('output/water-latent-%i.png',i),x_water,Width_water,Height_water)
    x_dmmp = w_dmmp(:,1) + min(w_dmmp(:,1)); x_dmmp = x_dmmp/max(x_dmmp);
    arr2img(sprintf('output/dmmp-latent-%i.png',i),x_dmmp,Width_dmmp,Height_dmmp)

    % plot the principal component trajectories
    t_water= X_water* w_water;
    t_dmmp = X_dmmp  * w_dmmp;

    figure(1);clf; hold on; box on; grid on;
    plot(t_water(:,1),t_water(:,2),'r-')
    plot(t_dmmp(:,1),t_dmmp(:,2),'b')
    xlabel('Principal Component 1');ylabel('Principal Component 2')
    legend('water','dmmp')
    saveas(figure(1),sprintf('output/pc_plot_%i.eps',i),'epsc')
end

% function that imports avi into array
function [X,Width,Height]=avi2arr(filepath)
    vd = VideoReader(filepath);
    Width = vd.Width; Height=vd.Height;
    X=[];
    while hasFrame(vd)
        X = [X;reshape(double(rgb2gray(readFrame(vd)))/256,[],1)'];
    end
end

% function that exports array into static image
function arr2img(filepath,x,Width,Height)
    imwrite(reshape(x,Height,Width),filepath,'png');
end