%%%%% 設置場所，ノード数などを決める関数 %%%%%
%%%%% 最初に実行すること %%%%%
%%%%% 設置場所 %%%%%
settingplace = 4;
%%%%% 使い捨て変数 %%%%%
waste = 1;
%%%%% 総ノード数 %%%%%
totalnode = 5; % 変更

%%%%% 各設置場所のノード数 %%%%%
%%%%% 2個(設置番号:1)　1個(設置番号:2～4) %%%%%
%%%%% それと，送信ノード数の定義 %%%%%
for i = 1:settingplace
   if i == 1
      place(i).nodenumber = 2;
   else
      place(i).nodenumber = 1;
   end
   place(i).sendingnode = 0;
   place(i).numbertonumber = zeros(1,2);
end

% ここで，設置個所のノードを番号で示すことにする.
for i = 1:settingplace
    for j=1:place(i).nodenumber
        if place(i).numbertonumber(1) == 0
            place(i).numbertonumber(1) = waste;
        end
        place(i).numbertonumber(2) = waste;
        waste = waste +1;
    end
end

% 人体箇所の番号(一応)
for i = 1:settingplace
   place(i).number = i;
end