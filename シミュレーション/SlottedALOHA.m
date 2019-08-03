function[register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace)

%%%%% 基本値の計算 %%%%%
count = count + 1;
register(1,count) = register(1,count-1) + slottime;

%%%%% 送信権を与える(どのノードがCAPで送信できるのかを決める) %%%%%
%%%%% パケットを持っているなら，送信可能状態に移行する %%%%%
for j = 1:totalnode
    if node(j).state == 1
        if node(j).waittime <= 0
            node(j).state = 2;
        end
    end
end

[register,node,place] = packetsend(register,count,sellnumber,SAR,parameter,slottime,node,bit,totalnode,place,settingplace);
[node] = packetgeneration(node,totalnode,slottime);