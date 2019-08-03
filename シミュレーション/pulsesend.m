%温度上昇の解析の部分を関数にする
%1シンボルタイムを2つに分ける形で温度上昇の解析
%解析領域は筋肉のSAR最大点付近の5×5の二次元領域における値を用いて温度上昇の解析(断熱条件)
%以下、生体熱輸送方程式による計算

function[register,place] = pulsesend(register,count,sellnumber,SAR,parameter,slottime,bit,place,i)

%%%%% 使い捨て変数 %%%%%
%%%%% 温度を保存しておく変数 %%%%%
Tw = zeros(sellnumber,sellnumber); %作業用変数(sellnumber×sellnumberの2次元配列)

%温度上昇の解析(境界では外部との熱交換はないものとして断熱)
%packet
[Tw] = dataframesend(bit.dataframe,sellnumber,parameter,SAR,Tw,place,i); % データフレームの送信
%pSIFS(2回目)：送信なし
place(i).T(2:sellnumber-1,2:sellnumber-1) = Tw(2:sellnumber-1,2:sellnumber-1)+place(i).time.IFS/(parameter.p*parameter.c)*(parameter.k*((Tw(3:sellnumber,2:sellnumber-1)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tw(2:sellnumber-1,3:sellnumber)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tw(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %差分化した生体熱輸送方程式
%ダミーのセルの値の設定
place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %上の行のダミーセルの設定
place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %左の列のダミーセルの設定
place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %右の列のダミーセルの設定
place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %下の行のダミーセルの設定

%I-ACK
[Tw] = dataframesend(bit.IACK,sellnumber,parameter,SAR,Tw,place,i); % IACKの受信　同電力とした
%remaining time：送信なし
place(i).T(2:sellnumber-1,2:sellnumber-1) = Tw(2:sellnumber-1,2:sellnumber-1)+place(i).time.remain/(parameter.p*parameter.c)*((parameter.k*(Tw(3:sellnumber,2:sellnumber-1)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tw(2:sellnumber-1,3:sellnumber)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tw(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %差分化した生体熱輸送方程式
%ダミーのセルの値の設定
place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %上の行のダミーセルの設定
place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %左の列のダミーセルの設定
place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %右の列のダミーセルの設定
place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %下の行のダミーセルの設定

%%%%% ALOHA方式のスロット長に対して残りの分を計算する
if (slottime > place(i).time.packet)
    dt = slottime - place(i).time.packet; % 計算しやすいように定義する
    
    place(i).T(2:sellnumber-1,2:sellnumber-1) = place(i).T(2:sellnumber-1,2:sellnumber-1)+dt/(parameter.p*parameter.c)*((parameter.k*(place(i).T(3:sellnumber,2:sellnumber-1)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(place(i).T(2:sellnumber-1,3:sellnumber)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(place(i).T(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %差分化した生体熱輸送方程式
    %ダミーのセルの値の設定
    place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %上の行のダミーセルの設定
    place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %左の列のダミーセルの設定
    place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %右の列のダミーセルの設定
    place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %下の行のダミーセルの設定
end


%任意の場所の温度を一つの配列に記録
register(i+1,count) = place(i).T((sellnumber+3)/2,(sellnumber+3)/2); %温度を記録
place(i).temperature = place(i).T((sellnumber+3)/2,(sellnumber+3)/2);