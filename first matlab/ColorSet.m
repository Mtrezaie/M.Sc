function ColorSet(key1,TextColor,BackgroundColor,KeyColor,StKeyColor)
% keys
T1 = key1.tag; 
T2 = [key1.tag_st_cl;unique(key1.tag_st_r,'rows')] ;
T3 = ['TextBox';'TX     ';'Screen '] ;
%% keys
for i = 1:length(T1)
set(findobj('tag',deblank(T1(i,:))),'BackgroundColor',KeyColor) ;
set(findobj('tag',deblank(T1(i,:))),'ForegroundColor',TextColor) ;
end
%% St keys
for i = 1:length(T2)
set(findobj('tag',deblank(T2(i,:))),'ForegroundColor',StKeyColor);
set(findobj('tag',deblank(T2(i,:))),'BackgroundColor',StKeyColor);

end
%% screen and text box

set(findobj('tag',deblank(T3(1,:))),'BackgroundColor',KeyColor) ;
set(findobj('tag',deblank(T3(1,:))),'ForegroundColor',TextColor) ;

set(findobj('tag',deblank(T3(2,:))),'BackgroundColor',KeyColor) ;
set(findobj('tag',deblank(T3(2,:))),'ForegroundColor',TextColor) ;

set(findobj('tag',deblank(T3(3,:))),'Color',BackgroundColor) ;
end