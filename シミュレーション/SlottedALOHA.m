function[register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace)

%%%%% ��{�l�̌v�Z %%%%%
count = count + 1;
register(1,count) = register(1,count-1) + slottime;

%%%%% ���M����^����(�ǂ̃m�[�h��CAP�ő��M�ł���̂������߂�) %%%%%
%%%%% �p�P�b�g�������Ă���Ȃ�C���M�\��ԂɈڍs���� %%%%%
for j = 1:totalnode
    if node(j).state == 1
        if node(j).waittime <= 0
            node(j).state = 2;
        end
    end
end

[register,node,place] = packetsend(register,count,sellnumber,SAR,parameter,slottime,node,bit,totalnode,place,settingplace);
[node] = packetgeneration(node,totalnode,slottime);