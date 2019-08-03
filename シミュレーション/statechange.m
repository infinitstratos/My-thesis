%%%%% デューティ比を変えたり，送信頻度を変えたりする %%%%%
function[place,node] = statechange(place,node,bit,settingplace,slottime)

for i = 1:settingplace
   if ((place(i).state == 1) && (place(i).temperature >=37.3))
       place(i).state = 2; % 設置場所の現状態を変更 特に，マージンラインを超える時
   end
 [place,node] = intervalchange(place,node,slottime,i); % 送信間隔を変更する
 % [place] = dutychange(place,bit,i); %デューティ比を変更する
end