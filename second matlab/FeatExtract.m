function y = FeatExtract(x,mod)
%info
fs = 256 ;
switch mod
    case 'SVM1'
        con_x = reshape(x,size(x,1)*size(x,2),[]);
        %       W = pca(con_x') ;
        y = con_x';

    case 'SVM2'
        % down sampling
        r = 2 ;
        x = downsample(x,r) ;
        con_x = reshape(x,size(x,1)*size(x,2),[]);
        %         W = pca(con_x') ;
        y = con_x';

    case 'CNN2D normal'
        % down sampling
        r = 2 ;
        y = downsample(x,r) ;

    case 'CNN2D low diffrential' % 2d diffrential(One CH between CHs)

        % down sampling
        r = 2 ;
        x = downsample(x,r) ;
        % channel adding
        s = size(x,2) ;
        y = [];
        for i = 1:s
            y = cat(2,y,x(:,i)) ;
            if i<s
                y = cat(2,y,x(:,i+1)-x(:,i)) ;
            end
        end

    case 'CNN2D high diffrential' % 2d diffrential(all CH between CHs)
        % down sampling
        r = 2 ;
        x = downsample(x,r) ;
        % channel adding
        y = [];
        s = size(x,2) ;
        for i = 1:s
            y = cat(2,y,x(:,i)) ;

            for j = i:s
                if j<s
                    y = cat(2,y,x(:,j+1)-x(:,i)) ;
                end

            end
        end

    case 'CNN2D correlation' % correlation
        z = FeatExtract(x,'CNN2D normal') ;
        y = z'*z ;

    case 'CNN2D reshape' % reshape
        z = FeatExtract(x,'CNN2D normal') ;
        % reshaping
        s1 = size(z,1);
        s2 = size(z,2);
        s3=ceil(sqrt(s1*s2)) ;
        y = zeros(s3) ;
        y(1:end,1:s2) = z(1:s3,:) ;
        y(1:end , s2+1 : 2*s2) = z(s3+1:2*s3,:) ;
        y(1:(s1-2*s3),2*s2+1:3*s2) = z(2*s3+1:end,:) ;

    case 'CNN3D freq'
        z = FeatExtract(x,'CNN2D normal') ;
        Z = nan([size(z),2]) ;
        a = fft2(z) ;
        Z(:,:,1) = abs(a) ;
        Z(:,:,2) = angle(a) ;
        y = Z ;

    case 'CNN3D time freq' % time,phase,amplitude
        z = FeatExtract(x,'CNN2D normal') ;
        Z = nan([size(z),3]) ;
        a = fft2(z) ;
        Z(:,:,1) = z ;
        Z(:,:,2) = abs(a) ;
        Z(:,:,3) = angle(a) ;
        y = Z ;

    case 'CNN3D circshift low' % circular shifts
        z = FeatExtract(x,'CNN2D high diffrential') ;
        xx = circshift(z,1) ;
        xxx = circshift(z,-1) ;
        y = cat(3,x,xx,xxx) ;
case 'CNN3D ch circshift low' % circular shifts
        z = FeatExtract(x,'CNN2D high diffrential') ;
        xx = circshift(z',1)' ;
        xxx = circshift(z',-1)' ;
        y = cat(3,z,xx,xxx) ;
    case 'CNN3D normal shift low'
        n = 5;
        z = FeatExtract(x,'CNN2D high diffrential') ;
        z1 = z( 1:end-2*n ,:) ;
        z2 = z(1+n : end-n ,:) ;
        z3 = z(1+2*n : end ,:) ;
        y = cat(3,z1,z2,z3) ;
 
    case 'CNN3D normal ch shift low'
        n = 4;
        z = FeatExtract(x,'CNN2D high diffrential') ;
        z1 = z(:, 1:end-2*n ) ;
        z2 = z(:,1+n : end-n ) ;
        z3 = z(:,1+2*n : end ) ;
        y = cat(3,z1,z2,z3) ;
   
    case 'CNN3D circshift high'
        z = FeatExtract(x,'CNN2D normal') ;
        n = 11 ;
        y = nan([size(z),n]);
        for i = 1:n
            y(:,:,i) = circshift(z,i-6) ;
        end

    case 'CNN3D normal shift high'
        z = FeatExtract(x,'CNN2D high diffrential') ;
        n = 11 ;
        y = nan([size(z,1)-(n-1),size(z,2),n]);
        for i = 1:n
            y(:,:,i) = z(i:end-(n-i),:) ;
        end

    case 'CNN3D real'
        
        x = FeatExtract(x,'CNN2D normal') ;
        y = Ch3DMaker(x,'simple') ;
           
end
end