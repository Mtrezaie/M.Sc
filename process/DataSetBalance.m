function [data, label] = DataSetBalance(x , y,mode)
fs = 256 ;
LP = 0.1 ;
HP = 30 ;
l_cl1 = sum(y==1) ;
l_cl2 = numel(y) - l_cl1 ;
r = floor(l_cl2/l_cl1) ;
cl1 = x(y==1) ;
cl2 = x(y==-1) ;
mod = l_cl2 - r * l_cl1  ;

switch mode
    case 'repeat'
        data = cat(1,cl2,repmat(cl1,r,1));
        data = cat(1,data,cl1(1:mod)) ;
        label = [-1*ones(1,l_cl2),ones(1,l_cl1*r+mod)]';
    case 'AE'
        % class 1 data construction
        autoenc = trainAutoencoder(cl1,20,'MaxEpochs',1000,'UseGPU',true,'DecoderTransferFunction','satlin'...
            ,'EncoderTransferFunction','logsig','SparsityProportion',1) ;
        AE_cl1 = {};

        for i = 1: (r-1)
            AE_cl1 = cat(1,AE_cl1,predict(autoenc,cl1)') ;
        end
        AE_cl1 = cat(1,AE_cl1,predict(autoenc,cl1(1:mod))') ;
        % filtering encoded data
        [b,a]=butter(4,[LP HP]/(fs/2),'bandpass');       % butterworth bandpass filter
        for i = 1:length(AE_cl1)
            AE_cl1{i} = filter(b,a,AE_cl1{i}) ;
        end
        data = [cl2;cl1;AE_cl1] ;
        label = [-1*ones(1,l_cl2),ones(1,l_cl1*r+mod)]';
end

end