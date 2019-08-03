%�����w�Ńp���X�𑗐M�����ꍇ���֐���(slottedALOHA�p)

function[Tm] = dataframesend(repeat,sellnumber,parameter,SAR,Tm,place,i) %���̉��x�ƌJ��Ԃ����������炤

%�o�[�X�g���̐ݒ�
Ncpb = 32;
%1�̃V���{���^�C����wave form position�̐��̐ݒ�
Nw = Ncpb/place(i).duty;
%�^�C���X�e�b�v�̐ݒ�
dt = 2 * 10^(-9) * Ncpb; %�o�[�X�g���̐ݒ�
dt2 = (Nw-1) * dt; %�p���X�𑗂��Ă��Ȃ��Ƃ���̒l�̐ݒ�

%%%%% �v�Z�񐔂��V�����ɂȂ�Ȃ��̂ŁC�ߎ������Ă��������܂� %%%%%
%%%%% ���\�_��(�Ӗ����ς���Ă���) %%%%%
for k = 1:repeat
%���x�㏸�̉��(���E�ł͊O���Ƃ̔M�����͂Ȃ����̂Ƃ��Ēf�M)(�ߎ��v�Z���Ă�̂ŁC���m���ɂ�����Ǝv����)
	%���x�㏸�̉��(���E�ł͊O���Ƃ̔M�����͂Ȃ����̂Ƃ��Ēf�M)
    %�p���X���Ǝ˂���Ƃ���
    Tm(2:sellnumber-1,2:sellnumber-1) = place(i).T(2:sellnumber-1,2:sellnumber-1) + dt/(parameter.p*parameter.c) *(parameter.k*((place(i).T(3:sellnumber,2:sellnumber-1)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(place(i).T(2:sellnumber-1,3:sellnumber)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(place(i).T(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.p*SAR(2:sellnumber-1,2:sellnumber-1)*place(i).sendingnode+ parameter.A +parameter.thermalsend*place(i).sendingnode+parameter.thermalcooling*(place(i).nodenumber-place(i).sendingnode)); %�������������̔M�A��������
    %�_�~�[�̃Z���̒l�̐ݒ�
    Tm(1,2:sellnumber-1) = Tm(2,2:sellnumber-1); %��̍s�̃_�~�[�Z���̐ݒ�
    Tm(2:sellnumber-1,1) = Tm(2:sellnumber-1,2); %���̗�̃_�~�[�Z���̐ݒ�
    Tm(2:sellnumber-1,sellnumber) = Tm(2:sellnumber-1,sellnumber-1); %�E�̗�̃_�~�[�Z���̐ݒ�
    Tm(sellnumber,2:sellnumber-1) = Tm(sellnumber-1,2:sellnumber-1); %���̍s�̃_�~�[�Z���̐ݒ�

    %�p���X���Ǝ˂��Ȃ��Ƃ���
    place(i).T(2:sellnumber-1,2:sellnumber-1) = Tm(2:sellnumber-1,2:sellnumber-1)+ dt2/(parameter.p*parameter.c) *(parameter.k*((Tm(3:sellnumber,2:sellnumber-1)-2*Tm(2:sellnumber-1,2:sellnumber-1)+Tm(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tm(2:sellnumber-1,3:sellnumber)-2*Tm(2:sellnumber-1,2:sellnumber-1)+Tm(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tm(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+ parameter.A +parameter.thermalcooling*place(i).nodenumber); %�������������̔M�A��������
    %�_�~�[�̃Z���̒l�̐ݒ�
    place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %��̍s�̃_�~�[�Z���̐ݒ�
    place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %���̗�̃_�~�[�Z���̐ݒ�
    place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %�E�̗�̃_�~�[�Z���̐ݒ�
    place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %���̍s�̃_�~�[�Z���̐ݒ�
end
    Tm(:,:) = place(i).T(:,:);