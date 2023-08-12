function positioner(key1,R1_x,R1_y,key_size,st_key_size)
if length(key1.num)<62
    key2_tag = ['TextBox';'TX     ';'Screen '] ;
else
    key2_tag = ['TextBox';'TX     ';'CON    ';'StCON  ';'Screen '] ;
end
% all keys
T = [key1.tag(1:61,:);key1.tag_st_cl(1:61,:);unique(key1.tag_st_r(1:61,:),'rows');key2_tag] ;
%% every units pixels
for i=1:length(T)
%         set(findobj('tag',deblank(T(i,:))),'visible','on') ;
    set(findobj('tag',deblank(T(i,:))),'Units','pixels') ;
    
end
%% main screen
pos = get(0,'MonitorPositions');       % (x,y,width,height)
sz = size(pos);
if (sz(1) > 1)
    panel_pos = pos(2,:);      % second monitor
    panel_pos(2) = 0;        % height
    panel_pos(3) = panel_pos(3)-pos(1,3);     % width
else
    panel_pos = pos(1,:);     % first monitor
end

set(findobj('tag',deblank(T(end,:))),'OuterPosition',panel_pos);

%% each object position
%% def
itmpos = ones(length(T),4) ;
%% sizes

Lx_key = key_size ;
Ly_key = Lx_key ;
st_key_second_space = st_key_size ;
st_key_third_space = st_key_second_space ;
R1_x = R1_x + st_key_third_space ;

%% row 1
% R1_x =105;
R1_x_dist = (1/12)*Lx_key ;
% R1_y = 545;
itmpos(123,:) = [R1_x-(st_key_size-key_size),R1_y,st_key_size,Ly_key];      % StR1
itmpos(1,:) = [itmpos(123,1)+itmpos(123,3) + R1_x_dist ,R1_y,Lx_key-0.25*Lx_key,Ly_key];        % R1C1
itmpos(2,:) = [itmpos(1,1)+itmpos(1,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];      % R1C2
itmpos(3,:) = [itmpos(2,1)+itmpos(2,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];           % R1C3
itmpos(4,:) = [itmpos(3,1)+itmpos(3,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C4
itmpos(5,:) = [itmpos(4,1)+itmpos(4,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C5
itmpos(6,:) = [itmpos(5,1)+itmpos(5,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C6
itmpos(7,:) = [itmpos(6,1)+itmpos(6,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C7
itmpos(8,:) = [itmpos(7,1)+itmpos(7,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C8
itmpos(9,:) = [itmpos(8,1)+itmpos(8,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];          % R1C9
itmpos(10,:) = [itmpos(9,1)+itmpos(9,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];        % R1C10
itmpos(11,:) = [itmpos(10,1)+itmpos(10,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];        % R1C11
itmpos(12,:) = [itmpos(11,1)+itmpos(11,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];        % R1C12
itmpos(13,:) = [itmpos(12,1)+itmpos(12,3) + R1_x_dist ,R1_y,Lx_key,Ly_key];        % R1C13
itmpos(14,:) = [itmpos(13,1)+itmpos(13,3) + R1_x_dist ,R1_y,Lx_key+(4/3)*Lx_key,Ly_key];        % R1C14
% StR1C
StR_y_dist = (13/12)*Ly_key ;
StR1C_odd_y = R1_y + StR_y_dist ;
StR1C_even_y = R1_y - StR_y_dist-(st_key_size-key_size) ;
itmpos(62,:) = [itmpos(1,1)+itmpos(1,3)/2 - Lx_key/2 ,StR1C_odd_y,Lx_key,st_key_size];        % StR1C1
itmpos(63,:) = [itmpos(2,1)+itmpos(2,3)/2 - Lx_key/2 ,StR1C_even_y,Lx_key,st_key_size];      % StR1C2
itmpos(64,:) = [itmpos(3,1)+itmpos(3,3)/2 - Lx_key/2 ,StR1C_odd_y+st_key_second_space,Lx_key,st_key_size];           % StR1C3
itmpos(65,:) = [itmpos(4,1)+itmpos(4,3)/2 - Lx_key/2 ,StR1C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR1C4
itmpos(66,:) = [itmpos(5,1)+itmpos(5,3)/2 - Lx_key/2 ,StR1C_odd_y,Lx_key,st_key_size];          % StR1C5
itmpos(67,:) = [itmpos(6,1)+itmpos(6,3)/2 - Lx_key/2 ,StR1C_even_y,Lx_key,st_key_size];          % StR1C6
itmpos(68,:) = [itmpos(7,1)+itmpos(7,3)/2 - Lx_key/2 ,StR1C_odd_y+st_key_second_space,Lx_key,st_key_size];          % StR1C7
itmpos(69,:) = [itmpos(8,1)+itmpos(8,3)/2 - Lx_key/2 ,StR1C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR1C8
itmpos(70,:) = [itmpos(9,1)+itmpos(9,3)/2 - Lx_key/2 ,StR1C_odd_y,Lx_key,st_key_size];          % StR1C9
itmpos(71,:) = [itmpos(10,1)+itmpos(10,3)/2 - Lx_key/2 ,StR1C_even_y,Lx_key,st_key_size];          % StR1C10
itmpos(72,:) = [itmpos(11,1)+itmpos(11,3)/2 - Lx_key/2 ,StR1C_odd_y+st_key_second_space,Lx_key,st_key_size];        % StR1C11
itmpos(73,:) = [itmpos(12,1)+itmpos(12,3)/2 - Lx_key/2 ,StR1C_even_y-st_key_second_space,Lx_key,st_key_size];        % StR1C12
itmpos(74,:) = [itmpos(13,1)+itmpos(13,3)/2 - Lx_key/2 ,StR1C_odd_y,Lx_key,st_key_size];        % StR1C13
itmpos(75,:) = [itmpos(14,1)+itmpos(14,3)/2 - Lx_key/2 ,StR1C_even_y,Lx_key,st_key_size];        % StR1C14



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% row 2
R2_y_dist = (13/12)*Ly_key;
R2_y = R1_y - R2_y_dist ;
R2_x_dist = (1/12)*Lx_key ;

itmpos(15,:) = [itmpos(1,1)  , R2_y , Lx_key+(1/3)*Lx_key , Ly_key];       % R2C1    %% tab
itmpos(16,:) = [itmpos(15,1)+itmpos(15,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C2
itmpos(17,:) = [itmpos(16,1)+itmpos(16,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C3
itmpos(18,:) = [itmpos(17,1)+itmpos(17,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C4
itmpos(19,:) = [itmpos(18,1)+itmpos(18,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C5
itmpos(20,:) = [itmpos(19,1)+itmpos(19,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C6
itmpos(21,:) = [itmpos(20,1)+itmpos(20,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C7
itmpos(22,:) = [itmpos(21,1)+itmpos(21,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C8
itmpos(23,:) = [itmpos(22,1)+itmpos(22,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C9
itmpos(24,:) = [itmpos(23,1)+itmpos(23,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C10
itmpos(25,:) = [itmpos(24,1)+itmpos(24,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C11
itmpos(26,:) = [itmpos(25,1)+itmpos(25,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C12
itmpos(27,:) = [itmpos(26,1)+itmpos(26,3) + R2_x_dist , R2_y , Lx_key , Ly_key];       % R2C13
itmpos(28,:) = [itmpos(27,1)+itmpos(27,3) + R2_x_dist,R2_y,Lx_key+(45/60)*Lx_key,Ly_key];        % R2C14
itmpos(124,:) = [itmpos(28,1)+itmpos(28,3) + R2_x_dist+st_key_second_space, R2_y , st_key_size , Ly_key];        % StR2

% StR2C
StR2C_odd_y = R2_y + StR_y_dist ;
StR2C_even_y = R2_y - StR_y_dist-(st_key_size-key_size) ;
itmpos(76,:) = [itmpos(15,1)+itmpos(15,3)/2 - Lx_key/2 ,StR2C_odd_y,Lx_key,st_key_size];        % StR2C1
itmpos(77,:) = [itmpos(16,1)+itmpos(16,3)/2 - Lx_key/2 ,StR2C_even_y,Lx_key,st_key_size];      % StR2C2
itmpos(78,:) = [itmpos(17,1)+itmpos(17,3)/2 - Lx_key/2 ,StR2C_odd_y+st_key_second_space,Lx_key,st_key_size];           % StR2C3
itmpos(79,:) = [itmpos(18,1)+itmpos(18,3)/2 - Lx_key/2 ,StR2C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR2C4
itmpos(80,:) = [itmpos(19,1)+itmpos(19,3)/2 - Lx_key/2 ,StR2C_odd_y,Lx_key,st_key_size];          % StR2C5
itmpos(81,:) = [itmpos(20,1)+itmpos(20,3)/2 - Lx_key/2 ,StR2C_even_y,Lx_key,st_key_size];          % StR2C6
itmpos(82,:) = [itmpos(21,1)+itmpos(21,3)/2 - Lx_key/2 ,StR2C_odd_y+st_key_second_space,Lx_key,st_key_size];          % StR2C7
itmpos(83,:) = [itmpos(22,1)+itmpos(22,3)/2 - Lx_key/2 ,StR2C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR2C8
itmpos(84,:) = [itmpos(23,1)+itmpos(23,3)/2 - Lx_key/2 ,StR2C_odd_y,Lx_key,st_key_size];          % StR2C9
itmpos(85,:) = [itmpos(24,1)+itmpos(24,3)/2 - Lx_key/2 ,StR2C_even_y,Lx_key,st_key_size];          % StR2C10
itmpos(86,:) = [itmpos(25,1)+itmpos(25,3)/2 - Lx_key/2 ,StR2C_odd_y+st_key_second_space,Lx_key,st_key_size];        % StR2C11
itmpos(87,:) = [itmpos(26,1)+itmpos(26,3)/2 - Lx_key/2 ,StR2C_even_y-st_key_second_space,Lx_key,st_key_size];        % StR2C12
itmpos(88,:) = [itmpos(27,1)+itmpos(27,3)/2 - Lx_key/2 ,StR2C_odd_y,Lx_key,st_key_size];        % StR2C13
itmpos(89,:) = [itmpos(28,1)+itmpos(28,3)/2 - Lx_key/2 ,StR2C_even_y,Lx_key,st_key_size];        % StR2C14



%% row 3
R3_y_dist =(13/12)*Ly_key;
R3_y = R2_y - R3_y_dist ;
R3_x_dist = (1/12)*Lx_key ;

itmpos(125,:) = [R1_x-(st_key_size-key_size)-st_key_second_space,R3_y,st_key_size,Ly_key];     % StR3
itmpos(29,:) = [itmpos(125,1)+itmpos(125,3)+st_key_second_space + R3_x_dist  , R3_y , 2*Lx_key , Ly_key];       % R3C1    %% tab
itmpos(30,:) = [itmpos(29,1)+itmpos(29,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C2
itmpos(31,:) = [itmpos(30,1)+itmpos(30,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C3
itmpos(32,:) = [itmpos(31,1)+itmpos(31,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C4
itmpos(33,:) = [itmpos(32,1)+itmpos(32,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C5
itmpos(34,:) = [itmpos(33,1)+itmpos(33,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C6
itmpos(35,:) = [itmpos(34,1)+itmpos(34,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C7
itmpos(36,:) = [itmpos(35,1)+itmpos(35,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C8
itmpos(37,:) = [itmpos(36,1)+itmpos(36,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C9
itmpos(38,:) = [itmpos(37,1)+itmpos(37,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C10
itmpos(39,:) = [itmpos(38,1)+itmpos(38,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C11
itmpos(40,:) = [itmpos(39,1)+itmpos(39,3) + R2_x_dist , R3_y , Lx_key , Ly_key];       % R3C12
itmpos(41,:) = [itmpos(40,1)+itmpos(40,3) + R2_x_dist , R3_y , Lx_key+(70/60)*Lx_key , Ly_key];       % R3C13

% StR3C
StR3C_odd_y = R3_y + StR_y_dist ;
StR3C_even_y = R3_y - StR_y_dist-(st_key_size-key_size) ;
itmpos(90,:) = [itmpos(29,1)+itmpos(29,3)/2 - Lx_key/2 ,StR3C_odd_y,Lx_key,st_key_size];        % StR3C1
itmpos(91,:) = [itmpos(30,1)+itmpos(30,3)/2 - Lx_key/2 ,StR3C_even_y,Lx_key,st_key_size];      % StR3C2
itmpos(92,:) = [itmpos(31,1)+itmpos(31,3)/2 - Lx_key/2 ,StR3C_odd_y+st_key_second_space,Lx_key,st_key_size];           % StR3C3
itmpos(93,:) = [itmpos(32,1)+itmpos(32,3)/2 - Lx_key/2 ,StR3C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR3C4
itmpos(94,:) = [itmpos(33,1)+itmpos(33,3)/2 - Lx_key/2 ,StR3C_odd_y,Lx_key,st_key_size];          % StR3C5
itmpos(95,:) = [itmpos(34,1)+itmpos(34,3)/2 - Lx_key/2 ,StR3C_even_y,Lx_key,st_key_size];          % StR3C6
itmpos(96,:) = [itmpos(35,1)+itmpos(35,3)/2 - Lx_key/2 ,StR3C_odd_y+st_key_second_space,Lx_key,st_key_size];          % StR3C7
itmpos(97,:) = [itmpos(36,1)+itmpos(36,3)/2 - Lx_key/2 ,StR3C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR3C8
itmpos(98,:) = [itmpos(37,1)+itmpos(37,3)/2 - Lx_key/2 ,StR3C_odd_y,Lx_key,st_key_size];          % StR3C9
itmpos(99,:) = [itmpos(38,1)+itmpos(38,3)/2 - Lx_key/2 ,StR3C_even_y,Lx_key,st_key_size];          % StR3C10
itmpos(100,:) = [itmpos(39,1)+itmpos(39,3)/2 - Lx_key/2 ,StR3C_odd_y+st_key_second_space,Lx_key,st_key_size];        % StR3C11
itmpos(101,:) = [itmpos(40,1)+itmpos(40,3)/2 - Lx_key/2 ,StR3C_even_y-st_key_second_space,Lx_key,st_key_size];        % StR3C12
itmpos(102,:) = [itmpos(41,1)+itmpos(41,3)/2 - Lx_key/2 ,StR3C_odd_y,Lx_key,st_key_size];        % StR3C13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% row 4
R4_y_dist =(13/12)*Ly_key;
R4_y = R3_y - R4_y_dist ;
R4_x_dist = (1/12)*Lx_key ;

itmpos(42,:) = [itmpos(1,1), R4_y , Lx_key+(85/60)*Lx_key , Ly_key];       % R4C1
itmpos(43,:) = [itmpos(42,1)+itmpos(42,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C2
itmpos(44,:) = [itmpos(43,1)+itmpos(43,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C3
itmpos(45,:) = [itmpos(44,1)+itmpos(44,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C4
itmpos(46,:) = [itmpos(45,1)+itmpos(45,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C5
itmpos(47,:) = [itmpos(46,1)+itmpos(46,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C6
itmpos(48,:) = [itmpos(47,1)+itmpos(47,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C7
itmpos(49,:) = [itmpos(48,1)+itmpos(48,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C8
itmpos(50,:) = [itmpos(49,1)+itmpos(49,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C9
itmpos(51,:) = [itmpos(50,1)+itmpos(50,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C10
itmpos(52,:) = [itmpos(51,1)+itmpos(51,3) + R4_x_dist , R4_y , Lx_key , Ly_key];       % R4C11
itmpos(53,:) = [itmpos(52,1)+itmpos(52,3) + R4_x_dist , R4_y , Lx_key+(110/60)*Lx_key , Ly_key];       % R4C12
itmpos(126,:) = [itmpos(53,1)+itmpos(53,3) + R4_x_dist,R4_y ,st_key_size,Ly_key];         % StR4

% StR4C
StR4C_odd_y = R4_y + StR_y_dist ;
StR4C_even_y = R4_y - StR_y_dist-(st_key_size-key_size) ;
itmpos(103,:) = [itmpos(42,1)+itmpos(42,3)/2 - Lx_key/2 ,StR4C_odd_y,Lx_key,st_key_size];        % StR4C1
itmpos(104,:) = [itmpos(43,1)+itmpos(43,3)/2 - Lx_key/2 ,StR4C_even_y,Lx_key,st_key_size];      % StR4C2
itmpos(105,:) = [itmpos(44,1)+itmpos(44,3)/2 - Lx_key/2 ,StR4C_odd_y+st_key_second_space,Lx_key,st_key_size];           % StR4C3
itmpos(106,:) = [itmpos(45,1)+itmpos(45,3)/2 - Lx_key/2 ,StR4C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR4C4
itmpos(107,:) = [itmpos(46,1)+itmpos(46,3)/2 - Lx_key/2 ,StR4C_odd_y,Lx_key,st_key_size];          % StR4C5
itmpos(108,:) = [itmpos(47,1)+itmpos(47,3)/2 - Lx_key/2 ,StR4C_even_y,Lx_key,st_key_size];          % StR4C6
itmpos(109,:) = [itmpos(48,1)+itmpos(48,3)/2 - Lx_key/2 ,StR4C_odd_y+st_key_second_space,Lx_key,st_key_size];          % StR4C7
itmpos(110,:) = [itmpos(49,1)+itmpos(49,3)/2 - Lx_key/2 ,StR4C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR4C8
itmpos(111,:) = [itmpos(50,1)+itmpos(50,3)/2 - Lx_key/2 ,StR4C_odd_y,Lx_key,st_key_size];          % StR4C9
itmpos(112,:) = [itmpos(51,1)+itmpos(51,3)/2 - Lx_key/2 ,StR4C_even_y,Lx_key,st_key_size];          % StR4C10
itmpos(113,:) = [itmpos(52,1)+itmpos(52,3)/2 - Lx_key/2 ,StR4C_odd_y+st_key_second_space,Lx_key,st_key_size];        % StR4C11
itmpos(114,:) = [itmpos(53,1)+itmpos(53,3)/2 - Lx_key/2 ,StR4C_even_y-st_key_second_space,Lx_key,st_key_size];        % StR4C12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% row 5
R5_y_dist =(13/12)*Ly_key;
R5_y = R4_y - R5_y_dist ;
R5_x_dist = (1/12)*Lx_key ;


itmpos(127,:) = [R1_x-(st_key_size-key_size),R5_y,st_key_size,Ly_key];%StR5
itmpos(54,:) = [itmpos(127,1)+itmpos(127,3) + R1_x_dist ,R5_y,Lx_key+(1/3)*Lx_key,Ly_key];        % R5C1
itmpos(55,:) = [itmpos(54,1)+itmpos(54,3) + R1_x_dist ,R5_y,Lx_key,Ly_key];      % R5C2
itmpos(56,:) = [itmpos(55,1)+itmpos(55,3) + R1_x_dist ,R5_y,Lx_key+(1/3)*Lx_key,Ly_key];           % R5C3
itmpos(57,:) = [itmpos(56,1)+itmpos(56,3) + R1_x_dist ,R5_y,Lx_key+(375/60)*Lx_key,Ly_key];          % R5C4
itmpos(58,:) = [itmpos(57,1)+itmpos(57,3) + R1_x_dist ,R5_y,Lx_key+(1/3)*Lx_key,Ly_key];          % R5C5
itmpos(59,:) = [itmpos(58,1)+itmpos(58,3) + R1_x_dist ,R5_y,Lx_key,Ly_key];          % R5C6
itmpos(60,:) = [itmpos(59,1)+itmpos(59,3) + R1_x_dist ,R5_y,Lx_key,Ly_key];          % R5C7
itmpos(61,:) = [itmpos(60,1)+itmpos(60,3) + R1_x_dist ,R5_y,Lx_key+(1/3)*Lx_key,Ly_key];          % R5C8

% StR5C
StR5C_odd_y = R5_y + StR_y_dist ;
StR5C_even_y = R5_y - StR_y_dist-(st_key_size-key_size) ;
itmpos(115,:) = [itmpos(54,1)+itmpos(54,3)/2 - Lx_key/2 ,StR5C_odd_y,Lx_key,st_key_size];        % StR5C1
itmpos(116,:) = [itmpos(55,1)+itmpos(55,3)/2 - Lx_key/2 ,StR5C_even_y,Lx_key,st_key_size];      % StR5C2
itmpos(117,:) = [itmpos(56,1)+itmpos(56,3)/2 - Lx_key/2 ,StR5C_odd_y+st_key_second_space,Lx_key,st_key_size];           % StR5C3
itmpos(118,:) = [itmpos(57,1)+itmpos(57,3)/2 - Lx_key/2 ,StR5C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR5C4
itmpos(119,:) = [itmpos(58,1)+itmpos(58,3)/2 - Lx_key/2 ,StR5C_odd_y,Lx_key,st_key_size];          % StR5C5
itmpos(120,:) = [itmpos(59,1)+itmpos(59,3)/2 - Lx_key/2 ,StR5C_even_y,Lx_key,st_key_size];          % StR5C6
itmpos(121,:) = [itmpos(60,1)+itmpos(60,3)/2 - Lx_key/2 ,StR5C_odd_y+st_key_second_space,Lx_key,st_key_size];          % StR5C7
itmpos(122,:) = [itmpos(61,1)+itmpos(61,3)/2 - Lx_key/2 ,StR5C_even_y-st_key_second_space,Lx_key,st_key_size];          % StR5C8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
itmpos(128,:) = [30,itmpos(64,2)+itmpos(64,4)+ key_size,700,130] ;      % TextBox
itmpos(129,:) = [75,itmpos(128,2)+35,610,60] ;       % TX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% monitor specific poses(scaling)

% itmpos(:,1:2) = (itmpos(:,1:2) / 1920) * panel_pos(3) ;
% itmpos(:,3:4) = (itmpos(:,3:4) / 1080) * panel_pos(4) ;

%% control key
if length(key1.num)>61
    Lx_CON = Lx_key ;
    Ly_CON = Lx_CON ;
    itmpos(131,:) = [itmpos(124,1)+itmpos(124,3)-Lx_CON , itmpos(122,2) , Lx_CON , Ly_CON ] ;
    itmpos(130,:) = [ itmpos(131,1),itmpos(131,2)+itmpos(131,4),Lx_key,Ly_CON ] ;
end
%% pos inserting
for i = 1:length(T)-1
    set(findobj('tag',deblank(T(i,:))),'Position',itmpos(i,:));
end


end
