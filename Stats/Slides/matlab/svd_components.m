% Victor Z
% UW-Madison, 2019
% use svd to compress and image
% https://www.mathworks.com/help/stats/pca.html

clc
clear all
close all hidden

%reading and converting the image
inImage=imread('babyviking.jpg');
inImage=rgb2gray(inImage);
inImageD=double(inImage); % this is a matrix!

figure(1);
imshow(uint8(inImageD));

% decomposing the image using singular value decomposition
[U,S,V]=svd(inImageD);

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = [];
numSVals = [];
bytesVals = [];

Nv = 1:9;

for idx=1:length(Nv)
    
    N = Nv(idx);

    % extract N-th component
    D=U(:,N)*S(N,N)*V(:,N)';
    
    % create image using accumulated components
    if idx==1
        Dcum=D;
    else
        Dcum=Dcum+D;
    end
    
    figure(2)
    subplot(3,3,idx)
    imshow(uint8(D));
    
    figure(3)
    subplot(3,3,idx)
    imshow(uint8(Dcum));
      
end
figure(2)
print -depsc singularvalues_viking.eps




