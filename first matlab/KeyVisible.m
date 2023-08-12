function KeyVisible(tag,Mod)
%% SHOWING OR HIDING KEYS
switch Mod
    case  1
        for i = 1:size(tag,1)
            set(findobj('tag',deblank(tag(i,:))),'visible','on');
        end
    case  0

        for i = 1:size(tag,1)
            set(findobj('tag',deblank(tag(i,:))),'visible','off');
        end
end
end