function out = EyeBlinkRemove(signal,EyeBlink,mod)

[l1,l2] = size(signal);
out = nan(l1,l2);
noise_out = nan(l1,l2);
%% lowpass for eye blink
l_win = 50;
b = ones(1,l_win)/l_win;
filt_EyeBlink = filter(b,1,EyeBlink);
switch mod
    case 'none'
        out = signal;
    case 'sub'
        out = signal - 0.2 * repmat(filt_EyeBlink,1,l2) ;
    case '1D'
        for i = 1:size(signal,2)
            [out(:,i),noise_out(:,i)] = wiener2(signal(:,i),[10,1],filt_EyeBlink) ;
        end

    case '2D'
       [out,noise_out] = wiener2(signal,[10,15],repmat(filt_EyeBlink,1,8)) ;
end


end

