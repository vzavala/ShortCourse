clc
clear all 
close all hidden

%% Define time and space discretizations
xi = linspace(-10,10,400);
t = linspace(0,4*pi,200); 
dt = t(2) - t(1);
[Xgrid,T] = meshgrid(xi,t);

%% Create two spatio-temporal patterns
f1 = sech(Xgrid) .* (1*exp(-2.3*T)) + (1*exp((-0.5+10*i)*T));
f2 = (Xgrid).*(2*exp(-0.8*T));

%% Combine signals and make data matrix
f = f1 + f2;
X = f.'; % Data Matrix

%% Visualize f1, f2, and f
figure(1);
subplot(2,2,1); 
surfl(real(f1)); 
shading interp; colormap(gray); view(-20,60);
set(gca, 'YTick', numel(t)/4 * (0:4)), 
set(gca, 'Yticklabel',{'0','\pi','2\pi','3\pi','4\pi'});
set(gca, 'XTick', linspace(1,numel(xi),3)), 
set(gca, 'Xticklabel',{'-10', '0', '10'});

subplot(2,2,2);
surfl(real(f2));
shading interp; colormap(gray); view(-20,60);
set(gca, 'YTick', numel(t)/4 * (0:4)), 
set(gca, 'Yticklabel',{'0','\pi','2\pi','3\pi','4\pi'});
set(gca, 'XTick', linspace(1,numel(xi),3)), 
set(gca, 'Xticklabel',{'-10', '0', '10'});

subplot(2,2,3);
surfl(real(f)); 
shading interp; colormap(gray); view(-20,60);
set(gca, 'YTick', numel(t)/4 * (0:4)), 
set(gca, 'Yticklabel',{'0','\pi','2\pi','3\pi','4\pi'});
set(gca, 'XTick', linspace(1,numel(xi),3)), 
set(gca, 'Xticklabel',{'-10', '0', '10'});

%% Create DMD data matrices
X1 = X(:, 1:end-1);
X2 = X(:, 2:end);

%% SVD and rank-2 truncation
r = 3; % rank truncation
[U, S, V] = svd(X1, 'econ');
Ur = U(:, 1:r); 
Sr = S(1:r, 1:r);
Vr = V(:, 1:r);

%% Build Atilde and DMD Modes
Atilde = Ur'*X2*Vr/Sr;
[W, D] = eig(Atilde);
Phi = X2*Vr/Sr*W;  % DMD Modes

%% DMD Spectra
lambda = diag(D);
omega = log(lambda)/dt

%% Compute DMD Solution
x1 = X(:, 1);
b = Phi\x1;
time_dynamics = zeros(r,length(t));
for iter = 1:length(t),
    time_dynamics(:,iter) = (b.*exp(omega*t(iter)));
end;
X_dmd = Phi*time_dynamics;

subplot(2,2,4); 
surfl(real(X_dmd')); 
shading interp; colormap(gray); view(-20,60);
set(gca, 'YTick', numel(t)/4 * (0:4)), 
set(gca, 'Yticklabel',{'0','\pi','2\pi','3\pi','4\pi'});
set(gca, 'XTick', linspace(1,numel(xi),3)), 
set(gca, 'Xticklabel',{'-10', '0', '10'});
set(gcf, 'Color', 'w', 'Position', [500 500 400 300]);
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 4 3], 'PaperPositionMode', 'manual');
%print('-djpeg', '-loose', ['../figures/' sprintf('dmd_intro1.jpeg')]);

figure(2)
subplot(2,2,1)
plot(real(time_dynamics'))
subplot(2,2,2)
plot(real(Phi))
