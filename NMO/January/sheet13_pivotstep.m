function [A,zrow] = sheet13_pivotstep(A,zrow,i,j)
 % performs pivot.
 % attach zrow on top of A
 A1=[zrow;A];
 [m,n]=size(A1);
 % divide row i by A1(i,j);
 A1(i,:)=A1(i,:)/A1(i,j);
 for k = 1:m
   if (k~=i)
     A1(k,:)=A1(k,:)-A1(k,j)*A1(i,:);
   end
 end
 A=A1(2:m,1:n);
 zrow=A1(1,1:n);
 tableau=A1
end
