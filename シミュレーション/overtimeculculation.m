function[place] = overtimeculculation(place,slottime,i)

%%% �v�Z���@�Ƃ��ẮC�o�b�t�@�ɕۑ��������Ԃƌ��݂̑̉���臒l�𒴂��Ă�����X���b�g���ԕ����Z���� %%%
if (place(i).temperaturebuffer < place(i).criterion) && (place(i).temperature >= place(i).criterion)
    place(i).overtime = (slottime * place(i).temperature)/(place(i).temperature + place(i).temperaturebuffer);
elseif (place(i).temperaturebuffer > place(i).criterion) && (place(i).temperature > place(i).criterion)
    place(i).overtime = place(i).overtime + slottime;
elseif (place(i).temperaturebuffer > place(i).criterion) && (place(i).temperature <= place(i).criterion)
    place(i).overtime = (slottime * place(i).temperaturebuffer)/(place(i).temperature + place(i).temperaturebuffer);
    
    %%% ���x������x����������̂ŁC�v�Z���� %%%
    place(i).overtimeparcent = place(i).overtimeparcent + place(i).overtime; % 臒l�𒴂��Ă���������
    if (place(i).overtime > place(i).maxsuccessiveovertime)
        place(i).maxsuccessiveovertime = place(i).overtime; % 臒l�𒴂��Ă����ő�̎���
    end
    
    %%% ���݂̒����Ă��鎞�Ԃ����Z�b�g %%%
    place(i).overtime = 0;
end
end