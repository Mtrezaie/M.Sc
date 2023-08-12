function [RCCode , ERRCode] = ERRLabelGen(key,code,ratio)
[s1,s2] = size(code) ;
n_Err = floor(ratio*s1*s2) ;
A = [zeros(1,s1*s2-n_Err),ones(1,n_Err)] ;
ERRCode = reshape(A(randperm(s1*s2)),s1,s2);

% fake row or colomn generation
%information
n_row = length(unique(key.row)) ;

% prealocation
RCCode = code ;
%row
for i = 1:s1
    while (RCCode(i,1) == code(i,1)) && (ERRCode(i,1) == 1)
        RCCode(i,1) =  randperm(n_row,1);
    end
end
%colomn
for i= 1:s1
    n_cl = length(unique(key.colomn(key.row==RCCode(i,1)))) ;
    while (RCCode(i,2) == code(i,2)) && (ERRCode(i,2) == 1)
        RCCode(i,2) =  randperm(n_cl,1);
    end
end
end