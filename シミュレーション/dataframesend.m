%物理層でパルスを送信した場合を関数化(slottedALOHA用)

function[Tm] = dataframesend(repeat,sellnumber,parameter,SAR,Tm,place,i) %今の温度と繰り返すかだけもらう

%バースト数の設定
Ncpb = 32;
%1つのシンボルタイムのwave form positionの数の設定
Nw = Ncpb/place(i).duty;
%タイムステップの設定
dt = 2 * 10^(-9) * Ncpb; %バースト数の設定
dt2 = (Nw-1) * dt; %パルスを送っていないところの値の設定

%%%%% 計算回数がシャレにならないので，近似させていただきます %%%%%
%%%%% 結構ダメ(意味が変わってくる) %%%%%
for k = 1:repeat
%温度上昇の解析(境界では外部との熱交換はないものとして断熱)(近似計算してるので，正確さにかけると思われる)
	%温度上昇の解析(境界では外部との熱交換はないものとして断熱)
    %パルスを照射するところ
    Tm(2:sellnumber-1,2:sellnumber-1) = place(i).T(2:sellnumber-1,2:sellnumber-1) + dt/(parameter.p*parameter.c) *(parameter.k*((place(i).T(3:sellnumber,2:sellnumber-1)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(place(i).T(2:sellnumber-1,3:sellnumber)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(place(i).T(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.p*SAR(2:sellnumber-1,2:sellnumber-1)*place(i).sendingnode+ parameter.A +parameter.thermalsend*place(i).sendingnode+parameter.thermalcooling*(place(i).nodenumber-place(i).sendingnode)); %差分化した生体熱輸送方程式
    %ダミーのセルの値の設定
    Tm(1,2:sellnumber-1) = Tm(2,2:sellnumber-1); %上の行のダミーセルの設定
    Tm(2:sellnumber-1,1) = Tm(2:sellnumber-1,2); %左の列のダミーセルの設定
    Tm(2:sellnumber-1,sellnumber) = Tm(2:sellnumber-1,sellnumber-1); %右の列のダミーセルの設定
    Tm(sellnumber,2:sellnumber-1) = Tm(sellnumber-1,2:sellnumber-1); %下の行のダミーセルの設定

    %パルスを照射しないところ
    place(i).T(2:sellnumber-1,2:sellnumber-1) = Tm(2:sellnumber-1,2:sellnumber-1)+ dt2/(parameter.p*parameter.c) *(parameter.k*((Tm(3:sellnumber,2:sellnumber-1)-2*Tm(2:sellnumber-1,2:sellnumber-1)+Tm(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tm(2:sellnumber-1,3:sellnumber)-2*Tm(2:sellnumber-1,2:sellnumber-1)+Tm(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tm(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+ parameter.A +parameter.thermalcooling*place(i).nodenumber); %差分化した生体熱輸送方程式
    %ダミーのセルの値の設定
    place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %上の行のダミーセルの設定
    place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %左の列のダミーセルの設定
    place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %右の列のダミーセルの設定
    place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %下の行のダミーセルの設定
end
    Tm(:,:) = place(i).T(:,:);