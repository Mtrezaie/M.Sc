function ColorChange(tag,color)

for i = 1:size(tag,1)
    set(findobj('tag',deblank(tag(i,:))),'BackgroundColor',color);
end

end