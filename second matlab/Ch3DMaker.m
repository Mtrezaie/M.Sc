function y = Ch3DMaker(x,mod)

switch mod
    
    case 'simple'
        channels = ['Fz ';'Cz ';'P3 ';'Pz ';'P4 ';'Po7';'Po8';'Oz '];
           
        ch_map = {
            '000','000','000','AFz','000','000','000';...
            '000','000','000','Fz ','000','000','000';...
            '000','Fc3','000','Fcz','000','Fc4','000';...
            '000','000','000','Cz ','000','000','000';...
            '000','Cp3','Cp1','CPz','Cp2','Cp4','000';...
            'P5 ','P3 ','000','Pz ','000','P4 ','P6 ';...
            '000','Po7','000','Poz','000','Po8','000';...
            '000','000','000','Oz ','000','000','000';...
            '000','000','000','000','000','000','000';...
            };
        [s1,s2] = size(ch_map) ;
        y = zeros(s1,s2,size(x,1)) ;
        for i = 1:s1
            for j = 1:s2
                k = find ( sum(ch_map{i,j} == (channels),2)==3 ) ;
                if ~isempty(k)
                    y(i,j,:) = x(:,k) ;
                end
            end
        end

    case 'ma'
        y = Ch3DMaker(x,'simple') ;
        for i = 1:size(y,3)
            y(:,:,i) = filter2(ones(3),y(:,:,i));
        end
                channels = ['Fz ';'Cz ';'P3 ';'Pz ';'P4 ';'Po7';'Po8';'Oz '];

        ch_map = {
            '000','000','000','AFz','000','000','000';...
            '000','000','000','Fz ','000','000','000';...
            '000','Fc3','000','Fcz','000','Fc4','000';...
            '000','000','000','Cz ','000','000','000';...
            '000','Cp3','Cp1','CPz','Cp2','Cp4','000';...
            'P5 ','P3 ','000','Pz ','000','P4 ','P6 ';...
            '000','Po7','000','Poz','000','Po8','000';...
            '000','000','000','Oz ','000','000','000';...
            '000','000','000','000','000','000','000';...
            };
        [s1,s2] = size(ch_map) ;
        for i = 1:s1
            for j = 1:s2
                k = find ( sum(ch_map{i,j} == (channels),2)==3 ) ;
                if ~isempty(k)
                    y(i,j,:) = x(:,k) ;
                end
            end
        end
end
end