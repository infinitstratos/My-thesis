function[node] = packetgeneration(node,totalnode,spendtime) % beaconだったり，フレーム長が変わったりするかもしれないので，経過時間を引数にすること

%%%%% 各ノードについてパケット生起を計算する %%%%%
for i = 1:totalnode
    %%%%% 時間経過，及び待ち時間を増やす%%%%%
    node(i).passtime = node(i).passtime - spendtime;
    node(i).waittime = node(i).waittime - spendtime;
    
    %%% もしパケットを持っていたら，遅延時間を計算 %%%
    if node(i).state == 1
        node(i).delaytime = node(i).delaytime + spendtime;
    end
    %%% もし，生起までの残り時間を切ったらパケット生起 %%%
    if node(i).passtime <= 0
      %%% パケットを持っていなかったら，遅延時間を計算 %%% 
      %%% その際，パケットを持っていたら，廃棄処分 %%%
      if node(i).state == 1
          node(i).disposal = node(i).disposal + 1; % 廃棄回数+1
      end
      node(i).state = 1; % パケット生起
      node(i).generation = node(i).generation + 1; % パケット生起回数を増やす
      
      %%% 経過時間をリセット %%%
      node(i).passtime = node(i).passtime + 1/node(i).offeredload; % この方法では，スロット内に2回以上パケット生起がした時には使えない
    end
end