function[place,node] = intervalchange(place,node,slottime,i)

if(place(i).state == 2)
    %%% 臒l�𒴂��Ă������Ԃ��v�Z %%%
    [place] = overtimeculculation(place,slottime,i);

    %%% ���M�Ԋu�K���I�ɕύX������v���O���� %%%
    if(place(i).changeinterval <= 0) % �ύX���Ԃ𒴂�����
        place(i).changeinterval = place(i).sendintervalchangetime; % �܂��̓��Z�b�g
        if(place(i).criterion <= place(i).temperature) % ����x�����̉�������������
                place(i).int = place(i).int + 1; % ���M�Ԋu���L������
        end
    end

    if (place(i).int <= 0)
        place(i).int = 1;
    elseif(place(i).int >16)
    place(i).int = place(i).int-1; % �ő�interval�����߂�
    end

    %%% ���M�Ԋu��ύX %%%
    if (i == 1)
        node(1).interval = place(1).int/node(1).offeredload;
        node(2).interval = place(1).int/node(2).offeredload;
    end
end

place(i).changeinterval = place(i).changeinterval - slottime;
