%%%%%%%%%% ���s�� �����̃X�[�p�[�t���[�����J��Ԃ��̂� %%%%%%%%%%
temperature_count = 50000; % �ύX/�X���[�v�b�g�̕��ς���邽�߂Ɏ��s�񐔂𑽂����Ă���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% �L�^����l %%%%%%%%%%%%%%%

h = waitbar(0,'Please wait'); %waitbar��ݒu
for i = 1:temperature_count
    %%%%% S-ALOHA�ɂ��� %%%%%
    [register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace);
    h = waitbar(i/temperature_count);
end
close(h)