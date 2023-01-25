%   "SLLN.m"
% illustrates the strong law of large numbers for
% - X~Exp(1),
% - discrete uniform distribution on {1,...,6}.
%

close all
clear all
pkg load statistics


% sample size
n = 100;
% #realizations ( omega_1, ..., omega_m )
m = 3;
% data
X = exprnd(1.0,n,m); % Exp(1)
%X = randi(6,n,m);   % unif. dist. on {1,...,6}

% running sample mean
XnBar = cumsum(X)./(1:n)';

% plot data
figure(1)
for j=1:m
  plot( 1:n, XnBar(:,j) );
  xlim([1 n]);
  ylim([0 7]);
  hold on;
  grid on;
end

% plot E(X_1)
plot(1:n,1.0);  % Exp(1)
%plot(1:n,3.5); % unif. dist. on {1,...,6}
