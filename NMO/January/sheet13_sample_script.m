% sample script for exercise sheet 13
% SIMPLEX ALGORITHM

format rat
% zrow and M have to be adapted:
zrow = [1 2 -2 3 0 0 0 5];
M = [0 3 1/2 0 -1 0 1 3;
     0 4  -2 1  5 1 0 2];

clc           % clear screen

fprintf('*** below: Phase I  ***\n')
[zrow;M]     % print current tableau
% Here, you can register the basic variables in each step:
fprintf('BV_0={a1,s2}\n')        

fprintf('*** below: Phase I ***\n')
% Consider the matrix representing your current tableau.
% Let zrow be the z-row and M represent the rows below.
% If you want to perform the pivot with pivot in row r and column k, enter:
% [M,zrow]=sheet13_pivotstep(M,zrow,r,c);
% e.g. perform pivot (with pivot in row 2 and column 3) for the matrix M
% and zrow: (note: the zrow is the FIRST row here)
[M,zrow]=sheet13_pivotstep(M,zrow,2,3);
fprintf('BV_1={x2,s2}\n')

fprintf('*** below: Phase I ***\n')
[M,zrow]=sheet13_pivotstep(M,zrow,3,5);
fprintf('BV_2={x2,s1}\n')

% here: further steps
% ...
% remove columns...
% Phase II,etc...
fprintf('*** below: Phase II ***\n')

% possibly, you want to revome the k-th column of a Matrix M. For this use:
% M(:,k)=[];
% e.g. M(:,3)=[] removes the 3rd column
% M(2,:)=[] removes the 2nd row
