function[register,count,node,place] = TDMA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace,tdma)

%%%%% ��{�l�̌v�Z %%%%%
count = count + 1;
register(1,count) = register(1,count-1) + slottime;

%%%%% ���M����^����(�ǂ̃m�[�h��CAP�ő��M�ł���̂������߂�) %%%%%
%%%%% �p�P�b�g�������Ă���Ȃ�C���M�\��ԂɈڍs���� %%%%%
if node(tdma).state == 1
    if node(tdma).waittime <= 0
            node(tdma).state = 2;
    end
end

[register,node,place] = packetsend(register,count,sellnumber,SAR,parameter,slottime,node,bit,totalnode,place,settingplace);
[node] = packetgeneration(node,totalnode,slottime);