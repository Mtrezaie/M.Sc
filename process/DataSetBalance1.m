function [data, label] = DataSetBalance1(x , y)

l_cl1 = sum(y) ;
l_cl2 = numel(y) - l_cl1 ;
r = floor(l_cl2/l_cl1) ;
cl1 = x(:,:,y==1) ;
cl2 = x(:,:,y==0) ;
mod = l_cl2 - r * l_cl1  ;
data = cat(3,cl2,repmat(cl1,1,1,r));
data = cat(3,data,cl1(:,:,1:mod)) ;
label = logical([zeros(1,l_cl2),ones(1,l_cl1*r+mod)]);


end