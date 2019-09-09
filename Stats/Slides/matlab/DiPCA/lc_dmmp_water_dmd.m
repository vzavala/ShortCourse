% dynamic principal component analysis
clear;close all; clc

ndataset=30; 
for i=ndataset:ndataset % for each data set
    fprintf('* data %i \n',i)
    
    % import the video into time-series array
    [X_water,Width_water,Height_water,Duration_water] = avi2arr(sprintf('data/water-%i.avi',i));
    
% Create DMD data matrices
 X = X_water';
[nx,nt]=size(X);
  dt = Duration_water/nt;
   t = 0:dt:(nt-1)*dt;
X1 = X(:, 1:end-1);
X2 = X(:, 2:end);

% SVD and rank-2 truncation
r = 9; % rank truncation
[U, S, V] = svd(X1,'econ');
Ur = U(:, 1:r); 
Sr = S(1:r, 1:r);
Vr = V(:, 1:r);
diag(Sr)

% Build Atilde and DMD Modes
Atilde = Ur'*X2*Vr/Sr;
[W, D] = eig(Atilde);
Phi = X2*Vr/Sr*W;  

% DMD Spectra
lambda = diag(D);
omega = log(lambda)/dt

% Compute DMD Solution
x1 = X(:, 1);
b = Phi\x1;
time_dynamics = zeros(r,length(t));
for iter = 1:length(t),
    time_dynamics(:,iter) = (b.*exp(omega*t(iter)));
end;
X_dmd = Phi*time_dynamics;

end

 % plot spatial modes
 for k=1:r
    w_water = Phi(:,k);
    x_water = w_water + min(w_water); 
    x_water = x_water/max(x_water); 
    figure(1)
    subplot(sqrt(r),sqrt(r),k)
    imshow(real(reshape(x_water,Height_water,Width_water)))
 end
    
% plot temporal modes
figure(2)
plot(t,real(time_dynamics'))
xlabel('Time [s]')
ylabel('Temporal Mode')

figure(3)
plot(t,mean(X))

% function that imports avi into array
function [X,Width,Height,Duration]=avi2arr(filepath)
    vd = VideoReader(filepath);
    Width = vd.Width; 
    Height = vd.Height;
    Duration = vd.Duration;
    X=[];
    while hasFrame(vd)
        X = [X;reshape(double(rgb2gray(readFrame(vd)))/256,[],1)'];
    end
end

% function that exports array into static image
function arr2img(filepath,x,Width,Height)
    imwrite(reshape(x,Height,Width),filepath,'png');
end