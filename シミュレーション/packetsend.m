function[register,node,place] = packetsend(register,count,sellnumber,SAR,parameter,slottime,node,bit,totalnode,place,settingplace)
%%%%% �����M�m�[�h�� %%%%%
totalsendingnode = 0;

%%%%% �����M�m�[�h���v�Z���� %%%%%
%%%%% �����C���M�����^�����Ă���Ȃ瑗�M���Ɉڍs���� %%%%%
for i = 1:settingplace
    for j = place(i).numbertonumber(1):place(i).numbertonumber(2)
        if node(j).state == 2
            node(j).transmission = node(j).transmission + 1;
            node(j).state = 3;
            place(i).sendingnode = place(i).sendingnode + 1; % �ݒu�ꏊ���Ƃɑ��M�m�[�h�����v�Z����D
            totalsendingnode = totalsendingnode + 1; % �����M�m�[�h���v�Z(�R���e���V�������Ă��邩�̊m�F�̂���)
        end
    end
end         

%%%%% ���x�v�Z %%%%%
for i = 1:settingplace
    [register,place] = pulsesend(register,count,sellnumber,SAR,parameter,slottime,bit,place,i);
end

%%%%% ����ԂɈڍs���� %%%%%
[node,place] = next(node,bit,totalnode,slottime,place,totalsendingnode,settingplace);