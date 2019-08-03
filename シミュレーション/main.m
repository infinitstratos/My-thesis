%%%%%%%%%% 基本値 %%%%%%%%%%%
%%%%% 細胞のセル %%%%%
sellnumber = 5;
%%%%% offeredload 変更 %%%%%
for i = 1:totalnode
   node(i).offeredload = 240/(totalnode*2); % 半分にした時にどうなるか確認
end

%%%%% SARについて %%%%%
%SARの値の初期値の設定
%筋肉のSAR最大点付近の値を用いる(Average SAR:0.8W/kgのときの値に変更)
SAR = zeros(sellnumber,sellnumber); %SARの値の初期化
%SARの値を手動で代入していく
SAR(2,2) = 55.92;
SAR(2,3) = 57.22;
SAR(2,4) = 57.22;
SAR(3,2) = 55.93;
SAR(3,3) = 57.22;
SAR(3,4) = 57.22;
SAR(4,2) = 55.19;
SAR(4,3) = 56.46;
SAR(4,4) = 56.46;

%%%%% parameter %%%%%
%%% セルサイズの設定 %%%
parameter.dx = 0.0005; %セルサイズ(x軸)
parameter.dy = 0.0005; %セルサイズ(y軸)
%%% 生体組織のパラメータ設定(筋肉) %%%
parameter.p = 1040; %生体の密度[kg/m^3]
parameter.c = 3600; %生体の比熱[J/kg・℃]
parameter.k = 0.50; %生体の熱伝導率[W/m・℃]
parameter.A = 690; %代謝熱の設定[W/m^3]
%%% 血液のパラメータ %%%
parameter.b = 2700; %血流定数の設定[W/m^3・k](b=p*pb*cb*F)→筋肉のものに変更
parameter.Tb = 37.0; %血液の温度
%%% 機器の熱を考えるためのパラメータ設定 %%%
parameter.thermalsend = 30; %送信時の機器の熱[W]
parameter.thermalcooling = 0.1;

%%%%%%%%%% MAC層の定義 全て秒に直している %%%%%%%%%%
bit.dataframe = 8*(7+255+2); % header:7,data:255,FCS:2 octet
bit.IACK = 8*3  ; % 3octets
slottime = 0.009; % ALOHAスロットの長さをデューティ比3.125%の時の２倍と定義すると楽
slotlength = 10; % スロット数
tdma = 0; % 地点aのための割り当てノード
%%%%%%%%%% 試行回数 いくつのスーパーフレームを繰り返すのか %%%%%%%%%%
temperature_count = 10000; % 変更/スループットの平均を取るために試行回数を多くしている.slotlengthを加えたことで10000で最高にする
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% 常に変更させていく値 %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 温度について %%%%%%%%%%
for i = 1:settingplace
    
    %%%%% 基準温度の設定 %%%%%
    if (i == 1)
        place(i).criterion = 37.3;
    else
        place(i).criterion = 0;
    end
    
    place(i).T = zeros(sellnumber,sellnumber); % 設置個所ごとの温度
    if i == 1
        place(i).temperature = place(i).criterion; % 各設置場所の初期温&最大値とする．
    else
        place(i).temperature = 37;
    end
    place(i).T(:,:) = place(i).temperature; % 初期値の設定
    %%%%% パルスのデューティ比 %%%%%
    %%%%% 簡単のために設置場所でパルスのデューティ比を一定とする %%%%%
    place(i).duty = 3.125;% 変更(ここはx%で表示する)
    place(i).duty = place(i).duty/3.125; % 3.125% = 1としている(鮫島さんの定義を参考にする)
    
    %%%%% パケットの送信時間 %%%%%
    [place] = packettime(place,bit,i);
    
    %%%%% 設置場所の状態 %%%%%
    %%%%% 1:初期温度 2:37.3度を超えた時(マージンライン) 3:37.5度を超えた時(デンジャラスゾーン) %%%%%
    place(i).state = 1;
    
    %%%%% 送信間隔変更時間 %%%%%
    place(i).sendintervalchangetime = 0.09;
    
    %%%%% 送信間隔の整数 %%%%%
    place(i).int = 1;
    
    %%%%% 体温のバッファ %%%%%
    place(i).temperaturebuffer = 0;
    
    %%%%% 閾値を超えていた時間 %%%%%
    place(i).overtime = 0;
    
    %%%%% 温度が閾値を連続して超えていた最大の時間 %%%%%
    place(i).maxsuccessiveovertime = 0;
    
    %%%%% 全体のシミュレーション時間に対して，閾値を超えていた時間の割合 %%%%%
    place(i).overtimeparcent = 0;
    
    %%%%% 送信間隔変更時間 %%%%%
    place(i).changeinterval = place(i).sendintervalchangetime;
end

%%%%%%%%%% パケットについて %%%%%%%%%%
for j = 1:totalnode
    %%%%% 各ノードの状態 %%%%%
    %%% 0:パケットを持っていない　1:パケットを持っている　2:パケットがあり，送信権を与えられた状態　3:送信中　4:送信成功　5:送信失敗　
    node(j).state = 0;
    
    %%%%% 送信までの残り待ち時間 %%%%%
    node(j).waittime = j/node(j).offeredload; % コンテンションを起こした時の待ち時間
    
    %%%%% パケットが生起するまでの残り時間　生起頻度をランダム %%%%%
    node(j).passtime = 1/node(j).offeredload;
    
    %%%%% パケットの送信間隔 %%%%%
    node(j).interval = 1/node(j).offeredload;
    
    %%%%% パケットの生起回数 %%%%%
    %%%%% 送信成功回数 + 廃棄回数 + 現在持っているパケット(0 or 1) %%%%%
    node(j).generation = 0;
    
    %%%%% パケットの送信成功回数 %%%%%
    node(j).succession = 0;
    
    %%%%% パケットの廃棄回数 %%%%%
    node(j).disposal = 0;
    
    %%%%% パケットの送信回数 %%%%%
    node(j).transmission = 0;
    
    %%%%% 各ノードのスループット %%%%%
    node(j).throughput = 0;
    
    %%%%% パケットのコンテンション回数 %%%%%
    node(j).contention = 0;
    
    %%%%% 現在の遅延時間 %%%%%
    node(j).delaytime = 0;
    
    %%%%% 平均遅延時間 %%%%%
    node(j).meandelay = 0;
    
    %%%%% 最低遅延時間 %%%%%
    node(j).worstdelaytime = 0;
    
    %%%%% 遅延量 %%%%%
    node(j).maxdelay = 0.25;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% その他 %%%%%%%%%%
%%%%% 現在の経過時間計算変数 %%%%%
count = 1; % 1は初期値に関することだから

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% 記録する値 %%%%%%%%%%%%%%%
%%%%%%%%%% 温度 %%%%%%%%%%
%%%%% ノード1とノード2は同じ個所にあるので，保存値は1つ少ない %%%%%
register = zeros(settingplace+1,temperature_count+1);
%%%%% 各ノード部の温度初期値 %%%%%
for i = 1:settingplace
    register(i+1,1) = place(i).temperature;
end
h = waitbar(0,'Please wait'); %waitbarを設置
for i = 1:temperature_count
    for j = 1:slotlength
        %%%%% S-ALOHAについて %%%%%
        [register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace);
    h = waitbar(((i-1)*slotlength+j)/(temperature_count*slotlength));
    end
end

for i = 1:settingplace
   place(i).overtimeparcent = place(i).overtime/(temperature_count*slottime);
end

for i = 1:totalnode
   node(i).meandelay = node(i).meandelay/node(i).succession; 
end
close(h)