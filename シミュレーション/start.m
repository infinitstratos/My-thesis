%%%%% �ݒu�ꏊ�C�m�[�h���Ȃǂ����߂�֐� %%%%%
%%%%% �ŏ��Ɏ��s���邱�� %%%%%
%%%%% �ݒu�ꏊ %%%%%
settingplace = 4;
%%%%% �g���̂ĕϐ� %%%%%
waste = 1;
%%%%% ���m�[�h�� %%%%%
totalnode = 5; % �ύX

%%%%% �e�ݒu�ꏊ�̃m�[�h�� %%%%%
%%%%% 2��(�ݒu�ԍ�:1)�@1��(�ݒu�ԍ�:2�`4) %%%%%
%%%%% ����ƁC���M�m�[�h���̒�` %%%%%
for i = 1:settingplace
   if i == 1
      place(i).nodenumber = 2;
   else
      place(i).nodenumber = 1;
   end
   place(i).sendingnode = 0;
   place(i).numbertonumber = zeros(1,2);
end

% �����ŁC�ݒu���̃m�[�h��ԍ��Ŏ������Ƃɂ���.
for i = 1:settingplace
    for j=1:place(i).nodenumber
        if place(i).numbertonumber(1) == 0
            place(i).numbertonumber(1) = waste;
        end
        place(i).numbertonumber(2) = waste;
        waste = waste +1;
    end
end

% �l�̉ӏ��̔ԍ�(�ꉞ)
for i = 1:settingplace
   place(i).number = i;
end