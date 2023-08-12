function sig = SignalNameCompare(address)
   

    names = strsplit(address,filesep);
    L = length(names) ;
    CMPP300 = zeros(1,L);
    CMPErrp = zeros(1,L);
    for i = 1:L
        if strcmpi('Errp',names{i})
            CMPErrp(i) = 1;
        elseif strcmpi('P300',names{i})
            CMPP300(i) = 1;
        end
    end
    if sum(CMPP300)
        sig = 'P300'
    elseif sum(CMPErrp)
        sig = 'Errp'
    end
end