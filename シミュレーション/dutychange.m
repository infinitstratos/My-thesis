function[place] = dutychange(place,bit,i)

%%%%% ���S���x�𒴂��Ă�����ύX����
if (place(i).state == 2)
    place(i).duty = place(i).duty/2; % �ݒu���̃f���[�e�B��𔼕��ɂ���    
    [place] = packettime(place,bit,i);
end