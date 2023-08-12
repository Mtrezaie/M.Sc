function indx = IndxGen(L)
indx = nan(L,1) ;
for i = 1:L
    if mod(i,2) == 0
        indx(i) = i/2 ;
    else
        indx(i) = L/2 + (i+1)/2;
    end
end