function[node,place] = next(node,bit,totalnode,slottime,place,totalsendingnode,settingplace)

%%%%% 総送信ノードの数によって，ノードの状態が変化する %%%%%
if totalsendingnode == 1
    for i = 1:totalnode
        if node(i).state == 3
            node(i).state = 4; % 送信成功
        end
    end
elseif totalsendingnode >= 2
    for i = 1:totalnode
        if node(i).state == 3
            node(i).state = 5; % 送信失敗
        end
    end
end

%%%%% この関数でデューティ比を変えたり，送信頻度を変える %%%%%
[place,node] = statechange(place,node,bit,settingplace,slottime);

%%%%% 次の状態の計算 %%%%%
for i = 1:totalnode
    if node(i).state == 4 % 送信に成功した時
        node(i).state = 0; % パケットを持っていない状態に
        node(i).succession = node(i).succession + 1; % 成功回数+1
        node(i).waittime = node(i).interval; % 再度送信するまでの時間を設定
        
        %%% 遅延時間の計算 %%%
        if ((node(i).delaytime) > (node(i).worstdelaytime))
           node(i).worstdelaytime = node(i).delaytime; % 最低遅延時間の更新
        end
        node(i).meandelay = node(i).meandelay + node(i).delaytime; % 平均遅延時間を計算
        node(i).delaytime = 0; % 遅延時間をリセット
    elseif node(i).state == 5 % 送信に失敗した時
        node(i).state = 1; % パケットを保持している状態にする
        node(i).contention = node(i).contention + 1; % コンテンション回数+1

        [node] = contentionwait(node,place,slottime,i);
    end
end

%%%%% 各設置個所の送信ノード数をリセットする
for i = 1:settingplace
    place(i).sendingnode = 0;
end