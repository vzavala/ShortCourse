%% CBE562
%% AR Time Series Model for Forecasting Campus Electrical Loads

clc;
close all;
clear;

%% Import data file 'load.dat'
Loads_data = importdata('load.dat'); % hourly load data

%% Plot first month data of electrical load
t_range = 1:720;
figure(1)
plot(t_range,Loads_data(t_range),'b');
grid on;
xlabel('Hours')
ylabel('Load (kW)')
xlim([1 720])


%% Autocorrelation in first month data of electrical load
% (Econometrics Toolbox must be installed)
figure(2)
autocorr(Loads_data(t_range),'NumLags', 48); % Plots the autocorrelation function


%% Training the AR time series model 
% Play around with the model_order, change the plot filenames
% correspondingly

model_order = 24*4;     % Degree of polynomial
n_training = 30*7*24; % No. of hours to be used for training
Loads_training = Loads_data(1:n_training); % Estimation data
Ts = 1; % Sampling time = 1 hour

model_ar = ar(iddata(Loads_training),model_order); % Gives the coefficients of the AR time-series polynomial 

%% Prediction and comparison with actual observed data
% Just Predicting at the first step for the full prediction horizon

n_pred = 7*24; % Number of points to predict
Loads_past = iddata(Loads_training(end-model_order:end)); % Past data points used to predict

[Loads_pred,X0,FMOD,YFSD] = forecast(model_ar, Loads_past, n_pred); % Gives the predicted loads and standard deviations

Loads_obs = Loads_data(n_training+(1:n_pred));
err_Loads = ((Loads_pred.y-Loads_obs))./Loads_obs*100;
upper_pred = Loads_pred.y + 3*YFSD; % 99.8% data lie within mean +- 3*stdev.
lower_pred = Loads_pred.y - 3*YFSD;

%% Plots of Forecasted vs Observed and Error

t = n_training-model_order:n_training+n_pred; 
t_pred = n_training+(1:n_pred);
gr = 0.8; % Gray color for plotting

figure(3)
hold on
grid on;
h2 = plot(t_pred,upper_pred,'color',[gr gr gr]);
h3 = plot(t_pred,lower_pred,'color',[gr gr gr]);
x2 = [t_pred, fliplr(t_pred)];
inBetween_upper = [Loads_pred.y', fliplr(upper_pred')];
fill_upper = fill(x2, inBetween_upper,[gr gr gr]);
set(fill_upper,'EdgeColor','None')
inBetween_lower = [Loads_pred.y', fliplr(lower_pred')];
fill_lower = fill(x2, inBetween_lower,[gr gr gr]);
set(fill_lower,'EdgeColor','None')
h0 = plot(t,[Loads_past.y;Loads_obs],'b'); 
h1 = plot(t_pred,Loads_pred.y,'r');
xlabel('Hours')
ylabel('Loads (kW)')
legend([h0 h1 fill_upper],'Observed','Mean Prediction','3*Stdev')
xlim([n_training-model_order n_training+n_pred])


figure(4)
plot(t_pred,abs(err_Loads),'r');
grid on;
xlabel('Hours')
ylabel('Prediction Error (%)')
xlim([n_training n_training+n_pred])

