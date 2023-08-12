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
       [out,noise_out] = wiener2(signal,[10,15],repmat(filt_EyeBlink,1,15)) ;
end

% plotting
close all
n1 = 70000;
n2 = 75000;
for ch = 1:l2
    figure('name',['cannel ',num2str(ch)]) ;
    subplot(4,1,1)
    plot(signal(n1:n2,ch));
    title('orginal')

    subplot(4,1,2)
    plot(filt_EyeBlink(n1:n2));
    title('blinks')

    subplot(4,1,3)
    plot(out(n1:n2,ch));
    title('cleaned')

    subplot(4,1,4)
    plot(noise_out(n1:n2,ch));
    title('noise')
end








end

