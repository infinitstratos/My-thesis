function[place] = packettime(place,bit,i)

%%%%% �e�m�[�h�̃f���[�e�B��Ɋ�Â����p�P�b�g�̑��M���� %%%%%
place(i).time.dataframe = bit.dataframe/(487*10^3*place(i).duty); % �b�ɕϊ�
place(i).time.IFS = 85 * 10^(-6); % �b�ɕϊ�
place(i).time.IACK = bit.IACK/(487*10^3*place(i).duty);
place(i).time.packet = place(i).time.dataframe + place(i).time.IFS + place(i).time.IACK; % �t���[���̑�����
place(i).time.remain = place(i).time.packet - (place(i).time.dataframe + place(i).time.IFS + place(i).time.IACK); % �t���[���̎c�莞��
if place(i).time.remain < 0
    place(i).time.remain = 0; % �c�莞�Ԃ�0��菬�����Ȃ�C0�ɂ���D
end