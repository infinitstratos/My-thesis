function[register,node,place] = packetsend(register,count,sellnumber,SAR,parameter,slottime,node,bit,totalnode,place,settingplace)
%%%%% 総送信ノード数 %%%%%
totalsendingnode = 0;

%%%%% 総送信ノードを計算する %%%%%
%%%%% もし，送信権が与えられているなら送信中に移行する %%%%%
for i = 1:settingplace
    for j = place(i).numbertonumber(1):place(i).numbertonumber(2)
        if node(j).state == 2
            node(j).transmission = node(j).transmission + 1;
            node(j).state = 3;
            place(i).sendingnode = place(i).sendingnode + 1; % 設置場所ごとに送信ノード数を計算する．
            totalsendingnode = totalsendingnode + 1; % 総送信ノードを計算(コンテンションしているかの確認のため)
        end
    end
end         

%%%%% 温度計算 %%%%%
for i = 1:settingplace
    [register,place] = pulsesend(register,count,sellnumber,SAR,parameter,slottime,bit,place,i);
end

%%%%% 次状態に移行する %%%%%
[node,place] = next(node,bit,totalnode,slottime,place,totalsendingnode,settingplace);