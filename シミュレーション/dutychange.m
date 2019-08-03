function[place] = dutychange(place,bit,i)

%%%%% 安全温度を超えていたら変更する
if (place(i).state == 2)
    place(i).duty = place(i).duty/2; % 設置個所のデューティ比を半分にする    
    [place] = packettime(place,bit,i);
end