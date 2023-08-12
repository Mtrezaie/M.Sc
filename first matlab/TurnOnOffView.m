function TurnOnOffView()
tag = 'CON' ;
ColorOff = [0.2,0.2,0.2];
ColorOn = [0.2,0.6,0.2];
mod = get(findobj('tag',tag),'BackgroundColor');

if mod == ColorOn
    set(findobj('tag',tag),'BackgroundColor',ColorOff);
elseif mod == ColorOff
    set(findobj('tag',tag),'BackgroundColor',ColorOn);
end
        
end