function[place,node] = intervalchange(place,node,slottime,i)

if(place(i).state == 2)
    %%% 閾値を超えていた時間を計算 %%%
    [place] = overtimeculculation(place,slottime,i);

    %%% 送信間隔適応的に変更させるプログラム %%%
    if(place(i).changeinterval <= 0) % 変更時間を超えたら
        place(i).changeinterval = place(i).sendintervalchangetime; % まずはリセット
        if(place(i).criterion <= place(i).temperature) % 基準温度よりも体温が高かったら
                place(i).int = place(i).int + 1; % 送信間隔を広くする
        end
    end

    if (place(i).int <= 0)
        place(i).int = 1;
    elseif(place(i).int >16)
    place(i).int = place(i).int-1; % 最大intervalを決める
    end

    %%% 送信間隔を変更 %%%
    if (i == 1)
        node(1).interval = place(1).int/node(1).offeredload;
        node(2).interval = place(1).int/node(2).offeredload;
    end
end

place(i).changeinterval = place(i).changeinterval - slottime;
