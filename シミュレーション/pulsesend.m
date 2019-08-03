%���x�㏸�̉�͂̕������֐��ɂ���
%1�V���{���^�C����2�ɕ�����`�ŉ��x�㏸�̉��
%��͗̈�͋ؓ���SAR�ő�_�t�߂�5�~5�̓񎟌��̈�ɂ�����l��p���ĉ��x�㏸�̉��(�f�M����)
%�ȉ��A���̔M�A���������ɂ��v�Z

function[register,place] = pulsesend(register,count,sellnumber,SAR,parameter,slottime,bit,place,i)

%%%%% �g���̂ĕϐ� %%%%%
%%%%% ���x��ۑ����Ă����ϐ� %%%%%
Tw = zeros(sellnumber,sellnumber); %��Ɨp�ϐ�(sellnumber�~sellnumber��2�����z��)

%���x�㏸�̉��(���E�ł͊O���Ƃ̔M�����͂Ȃ����̂Ƃ��Ēf�M)
%packet
[Tw] = dataframesend(bit.dataframe,sellnumber,parameter,SAR,Tw,place,i); % �f�[�^�t���[���̑��M
%pSIFS(2���)�F���M�Ȃ�
place(i).T(2:sellnumber-1,2:sellnumber-1) = Tw(2:sellnumber-1,2:sellnumber-1)+place(i).time.IFS/(parameter.p*parameter.c)*(parameter.k*((Tw(3:sellnumber,2:sellnumber-1)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tw(2:sellnumber-1,3:sellnumber)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tw(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %�������������̔M�A��������
%�_�~�[�̃Z���̒l�̐ݒ�
place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %��̍s�̃_�~�[�Z���̐ݒ�
place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %���̗�̃_�~�[�Z���̐ݒ�
place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %�E�̗�̃_�~�[�Z���̐ݒ�
place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %���̍s�̃_�~�[�Z���̐ݒ�

%I-ACK
[Tw] = dataframesend(bit.IACK,sellnumber,parameter,SAR,Tw,place,i); % IACK�̎�M�@���d�͂Ƃ���
%remaining time�F���M�Ȃ�
place(i).T(2:sellnumber-1,2:sellnumber-1) = Tw(2:sellnumber-1,2:sellnumber-1)+place(i).time.remain/(parameter.p*parameter.c)*((parameter.k*(Tw(3:sellnumber,2:sellnumber-1)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(Tw(2:sellnumber-1,3:sellnumber)-2*Tw(2:sellnumber-1,2:sellnumber-1)+Tw(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(Tw(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %�������������̔M�A��������
%�_�~�[�̃Z���̒l�̐ݒ�
place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %��̍s�̃_�~�[�Z���̐ݒ�
place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %���̗�̃_�~�[�Z���̐ݒ�
place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %�E�̗�̃_�~�[�Z���̐ݒ�
place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %���̍s�̃_�~�[�Z���̐ݒ�

%%%%% ALOHA�����̃X���b�g���ɑ΂��Ďc��̕����v�Z����
if (slottime > place(i).time.packet)
    dt = slottime - place(i).time.packet; % �v�Z���₷���悤�ɒ�`����
    
    place(i).T(2:sellnumber-1,2:sellnumber-1) = place(i).T(2:sellnumber-1,2:sellnumber-1)+dt/(parameter.p*parameter.c)*((parameter.k*(place(i).T(3:sellnumber,2:sellnumber-1)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(1:sellnumber-2,2:sellnumber-1))/(parameter.dx^2)+(place(i).T(2:sellnumber-1,3:sellnumber)-2*place(i).T(2:sellnumber-1,2:sellnumber-1)+place(i).T(2:sellnumber-1,1:sellnumber-2))/(parameter.dy^2))-parameter.b*(place(i).T(2:sellnumber-1,2:sellnumber-1)-parameter.Tb)+parameter.A+parameter.thermalcooling*place(i).nodenumber); %�������������̔M�A��������
    %�_�~�[�̃Z���̒l�̐ݒ�
    place(i).T(1,2:sellnumber-1) = place(i).T(2,2:sellnumber-1); %��̍s�̃_�~�[�Z���̐ݒ�
    place(i).T(2:sellnumber-1,1) = place(i).T(2:sellnumber-1,2); %���̗�̃_�~�[�Z���̐ݒ�
    place(i).T(2:sellnumber-1,sellnumber) = place(i).T(2:sellnumber-1,sellnumber-1); %�E�̗�̃_�~�[�Z���̐ݒ�
    place(i).T(sellnumber,2:sellnumber-1) = place(i).T(sellnumber-1,2:sellnumber-1); %���̍s�̃_�~�[�Z���̐ݒ�
end


%�C�ӂ̏ꏊ�̉��x����̔z��ɋL�^
register(i+1,count) = place(i).T((sellnumber+3)/2,(sellnumber+3)/2); %���x���L�^
place(i).temperature = place(i).T((sellnumber+3)/2,(sellnumber+3)/2);