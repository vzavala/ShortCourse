%use svd to compress and image
%https://www.mathworks.com/help/stats/pca.html

clc
clear all
close all hidden

%reading and converting the image
inImage=imread('babyviking.jpg');
inImage=rgb2gray(inImage);
inImageD=double(inImage); % this is a matrix!

figure;
imshow(uint8(inImageD));

% decomposing the image using singular value decomposition
[U,S,V]=svd(inImageD);

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = [];
numSVals = [];
bytesVals = [];

Nv = [1, 3, 10, 100];
figure;
for idx=1:length(Nv)
    
    N = Nv(idx);
    % store the singular values in a temporary var
    C = S;

    % discard the diagonal values not required for compression
    C(N+1:end,:)=0;
    C(:,N+1:end)=0;

    % Construct an Image using the selected singular values
    D=U*C*V';
    
    error=sum(sum((inImageD-D).^2));

    % display and compute error
    buffer = sprintf('k=%d, error=%0.2e', N, error)
    subplot(2,2,idx)
    imshow(uint8(D));
    title(buffer);
 
    % store vals for display
    dispEr = [dispEr; error];
    numSVals = [numSVals; N];
    
end

% dislay the error graph
figure; 
plot(numSVals, dispEr,'blue');
grid on
xlabel('k');
ylabel('Error');
axis([min(numSVals) max(numSVals) min(dispEr) max(dispEr)])
