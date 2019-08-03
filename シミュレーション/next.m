function[node,place] = next(node,bit,totalnode,slottime,place,totalsendingnode,settingplace)

%%%%% �����M�m�[�h�̐��ɂ���āC�m�[�h�̏�Ԃ��ω����� %%%%%
if totalsendingnode == 1
    for i = 1:totalnode
        if node(i).state == 3
            node(i).state = 4; % ���M����
        end
    end
elseif totalsendingnode >= 2
    for i = 1:totalnode
        if node(i).state == 3
            node(i).state = 5; % ���M���s
        end
    end
end

%%%%% ���̊֐��Ńf���[�e�B���ς�����C���M�p�x��ς��� %%%%%
[place,node] = statechange(place,node,bit,settingplace,slottime);

%%%%% ���̏�Ԃ̌v�Z %%%%%
for i = 1:totalnode
    if node(i).state == 4 % ���M�ɐ���������
        node(i).state = 0; % �p�P�b�g�������Ă��Ȃ���Ԃ�
        node(i).succession = node(i).succession + 1; % ������+1
        node(i).waittime = node(i).interval; % �ēx���M����܂ł̎��Ԃ�ݒ�
        
        %%% �x�����Ԃ̌v�Z %%%
        if ((node(i).delaytime) > (node(i).worstdelaytime))
           node(i).worstdelaytime = node(i).delaytime; % �Œ�x�����Ԃ̍X�V
        end
        node(i).meandelay = node(i).meandelay + node(i).delaytime; % ���ϒx�����Ԃ��v�Z
        node(i).delaytime = 0; % �x�����Ԃ����Z�b�g
    elseif node(i).state == 5 % ���M�Ɏ��s������
        node(i).state = 1; % �p�P�b�g��ێ����Ă����Ԃɂ���
        node(i).contention = node(i).contention + 1; % �R���e���V������+1

        [node] = contentionwait(node,place,slottime,i);
    end
end

%%%%% �e�ݒu���̑��M�m�[�h�������Z�b�g����
for i = 1:settingplace
    place(i).sendingnode = 0;
end