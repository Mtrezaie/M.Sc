function y = DecodeTR(key,TR)

L = length(TR) ;
r = zeros(1,L)' ;
c = zeros(1,L)' ;

for i = 1:L
    r(i) = key.row(deblank(key.LetE1(:,1))==TR(i)) ;
    c(i) = key.colomn(deblank(key.LetE1(:,1))==TR(i)) ;
end
y = [r , c] ;
end