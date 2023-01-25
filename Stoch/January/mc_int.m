%   "mc_int.m"
% Monte Carlo integration
% of a function g:[a,b]->R.
%

close all
clear all

% function g
g= @(x)(exp(-x.*x./2)./(sqrt(2*pi)));
% interval [a,b]
a = 0;
b = 2;
% #evaluations of g
n = 100;

% uniform distribution on [a,b]
U = a + (b-a)*rand(n,1);
% evaluation of g
gU = g(U);
% arithmetic mean
XnBar = cumsum(g(U))./(1:n)';
% approximation
approxInt = XnBar(n)*(b-a)

% plot
figure(1)
plot( U, gU, 'xb', -3:0.01:3, g(-3:0.01:3), '-r' );
xlim([-3 3]);
ylim([0 0.5]);
hold on;
grid on;

% plot XnBar
figure(2)
plot( (1:n)', XnBar*(b-a), '-' );
ylim([0 1]);
hold on;
grid on;
