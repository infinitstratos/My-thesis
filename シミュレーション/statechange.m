%%%%% �f���[�e�B���ς�����C���M�p�x��ς����肷�� %%%%%
function[place,node] = statechange(place,node,bit,settingplace,slottime)

for i = 1:settingplace
   if ((place(i).state == 1) && (place(i).temperature >=37.3))
       place(i).state = 2; % �ݒu�ꏊ�̌���Ԃ�ύX ���ɁC�}�[�W�����C���𒴂��鎞
   end
 [place,node] = intervalchange(place,node,slottime,i); % ���M�Ԋu��ύX����
 % [place] = dutychange(place,bit,i); %�f���[�e�B���ύX����
end