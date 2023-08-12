function y = KeyDeffine(mod)
switch mod
    case 'Online'
        n_key = 62 ;
        R = zeros(n_key,1) ;
        C = char(zeros(n_key,7));
        y = struct('num',R,'row',R,'colomn',R,'tag',C,'tag_st_r',C,'tag_st_cl',C,'LetE1',C,'LetE2',C) ;
%% values
        % key tags
        % row1
        y.tag(1,:) = 'R1C1   ' ;
        y.tag(2,:) = 'R1C2   ' ;
        y.tag(3,:) = 'R1C3   ' ;
        y.tag(4,:) = 'R1C4   ' ;
        y.tag(5,:) = 'R1C5   ' ;
        y.tag(6,:) = 'R1C6   ' ;
        y.tag(7,:) = 'R1C7   ' ;
        y.tag(8,:) = 'R1C8   ' ;
        y.tag(9,:) = 'R1C9   ' ;
        y.tag(10,:) = 'R1C10  ' ;
        y.tag(11,:) = 'R1C11  ' ;
        y.tag(12,:) = 'R1C12  ' ;
        y.tag(13,:) = 'R1C13  ' ;
        y.tag(14,:) = 'R1C14  ' ;
        % row2
        y.tag(15,:) = 'R2C1   ' ;
        y.tag(16,:) = 'R2C2   ' ;
        y.tag(17,:) = 'R2C3   ' ;
        y.tag(18,:) = 'R2C4   ' ;
        y.tag(19,:) = 'R2C5   ' ;
        y.tag(20,:) = 'R2C6   ' ;
        y.tag(21,:) = 'R2C7   ' ;
        y.tag(22,:) = 'R2C8   ' ;
        y.tag(23,:) = 'R2C9   ' ;
        y.tag(24,:) = 'R2C10  ' ;
        y.tag(25,:) = 'R2C11  ' ;
        y.tag(26,:) = 'R2C12  ' ;
        y.tag(27,:) = 'R2C13  ' ;
        y.tag(28,:) = 'R2C14  ' ;
        % row3
        y.tag(29,:) = 'R3C1   ' ;
        y.tag(30,:) = 'R3C2   ' ;
        y.tag(31,:) = 'R3C3   ' ;
        y.tag(32,:) = 'R3C4   ' ;
        y.tag(33,:) = 'R3C5   ' ;
        y.tag(34,:) = 'R3C6   ' ;
        y.tag(35,:) = 'R3C7   ' ;
        y.tag(36,:) = 'R3C8   ' ;
        y.tag(37,:) = 'R3C9   ' ;
        y.tag(38,:) = 'R3C10  ' ;
        y.tag(39,:) = 'R3C11  ' ;
        y.tag(40,:) = 'R3C12  ' ;
        y.tag(41,:) = 'R3C13  ' ;
        % row4
        y.tag(42,:) = 'R4C1   ' ;
        y.tag(43,:) = 'R4C2   ' ;
        y.tag(44,:) = 'R4C3   ' ;
        y.tag(45,:) = 'R4C4   ' ;
        y.tag(46,:) = 'R4C5   ' ;
        y.tag(47,:) = 'R4C6   ' ;
        y.tag(48,:) = 'R4C7   ' ;
        y.tag(49,:) = 'R4C8   ' ;
        y.tag(50,:) = 'R4C9   ' ;
        y.tag(51,:) = 'R4C10  ' ;
        y.tag(52,:) = 'R4C11  ' ;
        y.tag(53,:) = 'R4C12  ' ;
        % row5
        y.tag(54,:) = 'R5C1   ' ;
        y.tag(55,:) = 'R5C2   ' ;
        y.tag(56,:) = 'R5C3   ' ;
        y.tag(57,:) = 'R5C4   ' ;
        y.tag(58,:) = 'R5C5   ' ;
        y.tag(59,:) = 'R5C6   ' ;
        y.tag(60,:) = 'R5C7   ' ;
        y.tag(61,:) = 'R5C8   ' ;
        y.tag(62,:) = 'CON    ' ;
        % other fields
        for i=1:n_key-1
            % num
            y.num(i) = i ;
            % row num
            a = deblank(char(y.tag(i,:)));
            y.row(i) = str2double(a(2)) ;
            % colomn num
            if numel(a) == 4
                y.colomn(i) = str2double(a(4)) ;
            elseif numel(a) == 5
                y.colomn(i) = str2double(a([4,5])) ;
            end
            % row stimulation tag
            y.tag_st_r(i,:) = ['StR' , num2str(y.row(i)),'   '] ;
            % colomn stimulation tag
            y.tag_st_cl(i,:) = ['St' , a ,blanks(5-numel(a))] ;
        end
% control key
y.num(end) = n_key ;
y.row(end) = 0 ;
y.colomn(end) = 0 ;
y.tag_st_r(end,:) = 'StCON  ' ;
y.tag_st_cl(end,:) = 'StCON  ' ;
%% letter deffining
y.LetE1(1,:) = '`      ';
y.LetE2(1,:) = '~      ';

y.LetE1(2,:) = '1      ';
y.LetE2(2,:) = '!      ';

y.LetE1(3,:) = '2      ';
y.LetE2(3,:) = '@      ';

y.LetE1(4,:) = '3      ';
y.LetE2(4,:) = '#      ';

y.LetE1(5,:) = '4      ';
y.LetE2(5,:) = '$      ';

y.LetE1(6,:) = '5      ';
y.LetE2(6,:) = '%      ';

y.LetE1(7,:) = '6      ';
y.LetE2(7,:) = '^      ';

y.LetE1(8,:) = '7      ';
y.LetE2(8,:) = '&      ';

y.LetE1(9,:) = '8      ';
y.LetE2(9,:) = '*      ';

y.LetE1(10,:) = '9      ';
y.LetE2(10,:) = '(      ';

y.LetE1(11,:) = '0      ';
y.LetE2(11,:) = ')      ';

y.LetE1(12,:) = '-      ';
y.LetE2(12,:) = '_      ';

y.LetE1(13,:) = '=      ';
y.LetE2(13,:) = '+      ';

y.LetE1(14,:) = 'ESC    ';
%y.LetE2(15,:) = '';

% y.LetE1(15,:) = 'Tab    ';
%y.LetE2(15,:) = '';

y.LetE1(16,:) = 'q      ';
y.LetE2(16,:) = 'Q      ';

y.LetE1(17,:) = 'w      ';
y.LetE2(17,:) = 'W      ';

y.LetE1(18,:) = 'e      ';
y.LetE2(18,:) = 'E      ';

y.LetE1(19,:) = 'r      ';
y.LetE2(19,:) = 'R      ';

y.LetE1(20,:) = 't      ';
y.LetE2(20,:) = 'T      ';

y.LetE1(21,:) = 'y      ';
y.LetE2(21,:) = 'Y      ';

y.LetE1(22,:) = 'u      ';
y.LetE2(22,:) = 'U      ';

y.LetE1(23,:) = 'i      ';
y.LetE2(23,:) = 'I      ';

y.LetE1(24,:) = 'o      ';
y.LetE2(24,:) = 'O      ';

y.LetE1(25,:) = 'p      ';
y.LetE2(25,:) = 'P      ';

y.LetE1(26,:) = '[      ';
y.LetE2(26,:) = '{      ';

y.LetE1(27,:) = ']      ';
y.LetE2(27,:) = '}      ';

y.LetE1(28,:) = '\      ';
y.LetE2(28,:) = '|      ';

% y.LetE1(29,:) = 'Caps   ';
%y.LetE2(29,:) = '';

y.LetE1(30,:) = 'a      ';
y.LetE2(30,:) = 'A      ';

y.LetE1(31,:) = 's      ';
y.LetE2(31,:) = 'S      ';

y.LetE1(32,:) = 'd      ';
y.LetE2(32,:) = 'D      ';

y.LetE1(33,:) = 'f      ';
y.LetE2(33,:) = 'F      ';

y.LetE1(34,:) = 'g      ';
y.LetE2(34,:) = 'G      ';

y.LetE1(35,:) = 'h      ';
y.LetE2(35,:) = 'H      ';

y.LetE1(36,:) = 'j      ';
y.LetE2(36,:) = 'J      ';

y.LetE1(37,:) = 'k      ';
y.LetE2(37,:) = 'K      ';

y.LetE1(38,:) = 'l      ';
y.LetE2(38,:) = 'L      ';

y.LetE1(39,:) = ';      ';
y.LetE2(39,:) = ':      ';

% y.LetE1(40,:) = ' ';
%y.LetE2(40,:) = '"';

% y.LetE1(41,:) = 'Enter  ';
%y.LetE2(41,:) = '';

% y.LetE1(42,:) = 'Shift  ';
%y.LetE2(42,:) = '';

y.LetE1(43,:) = 'z      ';
y.LetE2(43,:) = 'Z      ';

y.LetE1(44,:) = 'x      ';
y.LetE2(44,:) = 'X      ';

y.LetE1(45,:) = 'c      ';
y.LetE2(45,:) = 'C      ';

y.LetE1(46,:) = 'v      ';
y.LetE2(46,:) = 'V      ';

y.LetE1(47,:) = 'b      ';
y.LetE2(47,:) = 'B      ';

y.LetE1(48,:) = 'n      ';
y.LetE2(48,:) = 'N      ';

y.LetE1(49,:) = 'm      ';
y.LetE2(49,:) = 'M      ';

y.LetE1(50,:) = ',      ';
y.LetE2(50,:) = '<      ';

y.LetE1(51,:) = '.      ';
y.LetE2(51,:) = '>      ';

y.LetE1(52,:) = '/      ';
y.LetE2(52,:) = '?      ';

% y.LetE1(53,:) = 'Shift  ';
%y.LetE2(53,:) = '';

% y.LetE1(54,:) = 'Ctrl   ';
%y.LetE2(54,:) = '';

%y.LetE1(55,:) = '';
%y.LetE2(55,:) = '';

% y.LetE1(56,:) = 'Alt    ';
%y.LetE2(56,:) = '';

y.LetE1(57,:) = ' ';
%y.LetE2(57,:) = '';

% y.LetE1(58,:) = 'Alt    ';
%y.LetE2(58,:) = '';

%y.LetE1(59,:) = '';
%y.LetE2(59,:) = '';

%y.LetE1(60,:) = '';
%y.LetE2(60,:) = '';

% y.LetE1(61,:) = 'Ctrl   ';
%y.LetE2(61,:) = '';

y.LetE1(62,:) = '';
y.LetE2(62,:) = '';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Offline'
        n_key = 61 ;
         R = zeros(n_key,1) ;
        C = char(zeros(n_key,7));
        y = struct('num',R,'row',R,'colomn',R,'tag',C,'tag_st_r',C,'tag_st_cl',C,'LetE1',C,'LetE2',C) ;
%% values
        % key tags
        % row1
        y.tag(1,:) = 'R1C1   ' ;
        y.tag(2,:) = 'R1C2   ' ;
        y.tag(3,:) = 'R1C3   ' ;
        y.tag(4,:) = 'R1C4   ' ;
        y.tag(5,:) = 'R1C5   ' ;
        y.tag(6,:) = 'R1C6   ' ;
        y.tag(7,:) = 'R1C7   ' ;
        y.tag(8,:) = 'R1C8   ' ;
        y.tag(9,:) = 'R1C9   ' ;
        y.tag(10,:) = 'R1C10  ' ;
        y.tag(11,:) = 'R1C11  ' ;
        y.tag(12,:) = 'R1C12  ' ;
        y.tag(13,:) = 'R1C13  ' ;
        y.tag(14,:) = 'R1C14  ' ;
        % row2
        y.tag(15,:) = 'R2C1   ' ;
        y.tag(16,:) = 'R2C2   ' ;
        y.tag(17,:) = 'R2C3   ' ;
        y.tag(18,:) = 'R2C4   ' ;
        y.tag(19,:) = 'R2C5   ' ;
        y.tag(20,:) = 'R2C6   ' ;
        y.tag(21,:) = 'R2C7   ' ;
        y.tag(22,:) = 'R2C8   ' ;
        y.tag(23,:) = 'R2C9   ' ;
        y.tag(24,:) = 'R2C10  ' ;
        y.tag(25,:) = 'R2C11  ' ;
        y.tag(26,:) = 'R2C12  ' ;
        y.tag(27,:) = 'R2C13  ' ;
        y.tag(28,:) = 'R2C14  ' ;
        % row3
        y.tag(29,:) = 'R3C1   ' ;
        y.tag(30,:) = 'R3C2   ' ;
        y.tag(31,:) = 'R3C3   ' ;
        y.tag(32,:) = 'R3C4   ' ;
        y.tag(33,:) = 'R3C5   ' ;
        y.tag(34,:) = 'R3C6   ' ;
        y.tag(35,:) = 'R3C7   ' ;
        y.tag(36,:) = 'R3C8   ' ;
        y.tag(37,:) = 'R3C9   ' ;
        y.tag(38,:) = 'R3C10  ' ;
        y.tag(39,:) = 'R3C11  ' ;
        y.tag(40,:) = 'R3C12  ' ;
        y.tag(41,:) = 'R3C13  ' ;
        % row4
        y.tag(42,:) = 'R4C1   ' ;
        y.tag(43,:) = 'R4C2   ' ;
        y.tag(44,:) = 'R4C3   ' ;
        y.tag(45,:) = 'R4C4   ' ;
        y.tag(46,:) = 'R4C5   ' ;
        y.tag(47,:) = 'R4C6   ' ;
        y.tag(48,:) = 'R4C7   ' ;
        y.tag(49,:) = 'R4C8   ' ;
        y.tag(50,:) = 'R4C9   ' ;
        y.tag(51,:) = 'R4C10  ' ;
        y.tag(52,:) = 'R4C11  ' ;
        y.tag(53,:) = 'R4C12  ' ;
        % row5
        y.tag(54,:) = 'R5C1   ' ;
        y.tag(55,:) = 'R5C2   ' ;
        y.tag(56,:) = 'R5C3   ' ;
        y.tag(57,:) = 'R5C4   ' ;
        y.tag(58,:) = 'R5C5   ' ;
        y.tag(59,:) = 'R5C6   ' ;
        y.tag(60,:) = 'R5C7   ' ;
        y.tag(61,:) = 'R5C8   ' ;
        % other fields
        for i=1:n_key
            % num
            y.num(i) = i ;
            % row num
            a = deblank(char(y.tag(i,:)));
            y.row(i) = str2double(a(2)) ;
            % colomn num
            if numel(a) == 4
                y.colomn(i) = str2double(a(4)) ;
            elseif numel(a) == 5
                y.colomn(i) = str2double(a([4,5])) ;
            end
            % row stimulation tag
            y.tag_st_r(i,:) = ['StR' , num2str(y.row(i)),'   '] ;
            % colomn stimulation tag
            y.tag_st_cl(i,:) = ['St' , a ,blanks(5-numel(a))] ;
        end
end
%% letter deffining
y.LetE1(1,:) = '`      ';
y.LetE2(1,:) = '~      ';

y.LetE1(2,:) = '1      ';
y.LetE2(2,:) = '!      ';

y.LetE1(3,:) = '2      ';
y.LetE2(3,:) = '@      ';

y.LetE1(4,:) = '3      ';
y.LetE2(4,:) = '#      ';

y.LetE1(5,:) = '4      ';
y.LetE2(5,:) = '$      ';

y.LetE1(6,:) = '5      ';
y.LetE2(6,:) = '%      ';

y.LetE1(7,:) = '6      ';
y.LetE2(7,:) = '^      ';

y.LetE1(8,:) = '7      ';
y.LetE2(8,:) = '&      ';

y.LetE1(9,:) = '8      ';
y.LetE2(9,:) = '*      ';

y.LetE1(10,:) = '9      ';
y.LetE2(10,:) = '(      ';

y.LetE1(11,:) = '0      ';
y.LetE2(11,:) = ')      ';

y.LetE1(12,:) = '-      ';
y.LetE2(12,:) = '_      ';

y.LetE1(13,:) = '=      ';
y.LetE2(13,:) = '+      ';

y.LetE1(14,:) = 'ESC    ';
%y.LetE2(15,:) = '';

y.LetE1(15,:) = 'Tab    ';
%y.LetE2(15,:) = '';

y.LetE1(16,:) = 'q      ';
y.LetE2(16,:) = 'Q      ';

y.LetE1(17,:) = 'w      ';
y.LetE2(17,:) = 'W      ';

y.LetE1(18,:) = 'e      ';
y.LetE2(18,:) = 'E      ';

y.LetE1(19,:) = 'r      ';
y.LetE2(19,:) = 'R      ';

y.LetE1(20,:) = 't      ';
y.LetE2(20,:) = 'T      ';

y.LetE1(21,:) = 'y      ';
y.LetE2(21,:) = 'Y      ';

y.LetE1(22,:) = 'u      ';
y.LetE2(22,:) = 'U      ';

y.LetE1(23,:) = 'i      ';
y.LetE2(23,:) = 'I      ';

y.LetE1(24,:) = 'o      ';
y.LetE2(24,:) = 'O      ';

y.LetE1(25,:) = 'p      ';
y.LetE2(25,:) = 'P      ';

y.LetE1(26,:) = '[      ';
y.LetE2(26,:) = '{      ';

y.LetE1(27,:) = ']      ';
y.LetE2(27,:) = '}      ';

y.LetE1(28,:) = '\      ';
y.LetE2(28,:) = '|      ';

y.LetE1(29,:) = 'Caps   ';
%y.LetE2(29,:) = '';

y.LetE1(30,:) = 'a      ';
y.LetE2(30,:) = 'A      ';

y.LetE1(31,:) = 's      ';
y.LetE2(31,:) = 'S      ';

y.LetE1(32,:) = 'd      ';
y.LetE2(32,:) = 'D      ';

y.LetE1(33,:) = 'f      ';
y.LetE2(33,:) = 'F      ';

y.LetE1(34,:) = 'g      ';
y.LetE2(34,:) = 'G      ';

y.LetE1(35,:) = 'h      ';
y.LetE2(35,:) = 'H      ';

y.LetE1(36,:) = 'j      ';
y.LetE2(36,:) = 'J      ';

y.LetE1(37,:) = 'k      ';
y.LetE2(37,:) = 'K      ';

y.LetE1(38,:) = 'l      ';
y.LetE2(38,:) = 'L      ';

y.LetE1(39,:) = ';      ';
y.LetE2(39,:) = ':      ';

% y.LetE1(40,:) = ' ';
%y.LetE2(40,:) = '"';

y.LetE1(41,:) = 'Enter  ';
%y.LetE2(41,:) = '';

y.LetE1(42,:) = 'Shift  ';
%y.LetE2(42,:) = '';

y.LetE1(43,:) = 'z      ';
y.LetE2(43,:) = 'Z      ';

y.LetE1(44,:) = 'x      ';
y.LetE2(44,:) = 'X      ';

y.LetE1(45,:) = 'c      ';
y.LetE2(45,:) = 'C      ';

y.LetE1(46,:) = 'v      ';
y.LetE2(46,:) = 'V      ';

y.LetE1(47,:) = 'b      ';
y.LetE2(47,:) = 'B      ';

y.LetE1(48,:) = 'n      ';
y.LetE2(48,:) = 'N      ';

y.LetE1(49,:) = 'm      ';
y.LetE2(49,:) = 'M      ';

y.LetE1(50,:) = ',      ';
y.LetE2(50,:) = '<      ';

y.LetE1(51,:) = '.      ';
y.LetE2(51,:) = '>      ';

y.LetE1(52,:) = '/      ';
y.LetE2(52,:) = '?      ';

y.LetE1(53,:) = 'Shift  ';
%y.LetE2(53,:) = '';

y.LetE1(54,:) = 'Ctrl   ';
%y.LetE2(54,:) = '';

%y.LetE1(55,:) = '';
%y.LetE2(55,:) = '';

y.LetE1(56,:) = 'Alt    ';
%y.LetE2(56,:) = '';

y.LetE1(57,:) = ' ';
%y.LetE2(57,:) = '';

y.LetE1(58,:) = 'Alt    ';
%y.LetE2(58,:) = '';

%y.LetE1(59,:) = '';
%y.LetE2(59,:) = '';

%y.LetE1(60,:) = '';
%y.LetE2(60,:) = '';

y.LetE1(61,:) = 'Ctrl   ';
%y.LetE2(61,:) = '';


end