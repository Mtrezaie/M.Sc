function label = LabelSave(label,mod,permut,tr,E,mod_O,varargin)



L = cell(1,size(label,2)) ;
L{1,1} = mod ;
L{1,2} = permut ;
L{1,3} = tr ;
L{1,4} = E ;

switch mod_O
    case 'Offline'
label = cat(1,label,L) ;

    case 'Online'
path = varargin{1} ;
label = cat(1,label,L) ;
save([path,'data\Online\label.mat'],'label','-mat') ;

    
 end


end