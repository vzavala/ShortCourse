% matlab example #5
% solve example 9.4 in textbook

clc
clear all
close all hidden

alpha=6.8; 
beta=0.5; 
cdfright = cdf('logn',1650,alpha,beta)
cdfleft = cdf('logn',350,alpha,beta)

Yield=cdfright-cdfleft
