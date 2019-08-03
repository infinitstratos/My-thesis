function[place] = packettime(place,bit,i)

%%%%% 各ノードのデューティ比に基づいたパケットの送信時間 %%%%%
place(i).time.dataframe = bit.dataframe/(487*10^3*place(i).duty); % 秒に変換
place(i).time.IFS = 85 * 10^(-6); % 秒に変換
place(i).time.IACK = bit.IACK/(487*10^3*place(i).duty);
place(i).time.packet = place(i).time.dataframe + place(i).time.IFS + place(i).time.IACK; % フレームの総時間
place(i).time.remain = place(i).time.packet - (place(i).time.dataframe + place(i).time.IFS + place(i).time.IACK); % フレームの残り時間
if place(i).time.remain < 0
    place(i).time.remain = 0; % 残り時間が0より小さいなら，0にする．
end