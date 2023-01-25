%   "CLT.m"
% illustrates the central limit theorem for
% - X~Exp(1),
% - discrete uniform distribution on {1,...,6}.
%

close all
clear all
pkg load statistics


% sample size
n = 10;
% #realizations ( omega_1, ..., omega_m )
m = 1000;
% data
X = exprnd(1.0,n,m); % Exp(1)
mu = 1.0;
sigma = 1;
%X = randi(6,n,m);   % unif. dist. on {1,...,6}
%mu = 3.5;
%sigma = sqrt(35/12.0);

% running normalized sum
XnBarStar = ( cumsum(X) .- mu*(1:n)' ) ...
  ./ sqrt((1:n)') / sigma;

% plot data
figure(1)
for i=1:n
  figure(i)
  hist( XnBarStar(i,:), 25, 1 )
end
