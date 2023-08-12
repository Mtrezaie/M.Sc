function y = WordSelect(key,r,c)

l = deblank(key.LetE1((key.row==r & key.colomn==c),:)) ;
% space case
 if strcmp(deblank(key.tag((key.row==r & key.colomn==c),:)), 'R5C4')
     l = ' ';
 end
sentence = get(findobj('tag','TX'),'String') ;

switch l
    case 'ESC'
        set(findobj('tag','TX'),'String' ,char(sentence(1:end-1)));

    otherwise
        set(findobj('tag','TX'),'String' ,[char(sentence),char(l)]);
end
end