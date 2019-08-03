function[place] = overtimeculculation(place,slottime,i)

%%% 計算方法としては，バッファに保存した時間と現在の体温が閾値を超えていたらスロット時間分加算する %%%
if (place(i).temperaturebuffer < place(i).criterion) && (place(i).temperature >= place(i).criterion)
    place(i).overtime = (slottime * place(i).temperature)/(place(i).temperature + place(i).temperaturebuffer);
elseif (place(i).temperaturebuffer > place(i).criterion) && (place(i).temperature > place(i).criterion)
    place(i).overtime = place(i).overtime + slottime;
elseif (place(i).temperaturebuffer > place(i).criterion) && (place(i).temperature <= place(i).criterion)
    place(i).overtime = (slottime * place(i).temperaturebuffer)/(place(i).temperature + place(i).temperaturebuffer);
    
    %%% 温度が基準温度を下回ったので，計算する %%%
    place(i).overtimeparcent = place(i).overtimeparcent + place(i).overtime; % 閾値を超えていた総時間
    if (place(i).overtime > place(i).maxsuccessiveovertime)
        place(i).maxsuccessiveovertime = place(i).overtime; % 閾値を超えていた最大の時間
    end
    
    %%% 現在の超えている時間をリセット %%%
    place(i).overtime = 0;
end
end