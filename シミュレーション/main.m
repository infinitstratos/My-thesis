%%%%%%%%%% ��{�l %%%%%%%%%%%
%%%%% �זE�̃Z�� %%%%%
sellnumber = 5;
%%%%% offeredload �ύX %%%%%
for i = 1:totalnode
   node(i).offeredload = 240/(totalnode*2); % �����ɂ������ɂǂ��Ȃ邩�m�F
end

%%%%% SAR�ɂ��� %%%%%
%SAR�̒l�̏����l�̐ݒ�
%�ؓ���SAR�ő�_�t�߂̒l��p����(Average SAR:0.8W/kg�̂Ƃ��̒l�ɕύX)
SAR = zeros(sellnumber,sellnumber); %SAR�̒l�̏�����
%SAR�̒l���蓮�ő�����Ă���
SAR(2,2) = 55.92;
SAR(2,3) = 57.22;
SAR(2,4) = 57.22;
SAR(3,2) = 55.93;
SAR(3,3) = 57.22;
SAR(3,4) = 57.22;
SAR(4,2) = 55.19;
SAR(4,3) = 56.46;
SAR(4,4) = 56.46;

%%%%% parameter %%%%%
%%% �Z���T�C�Y�̐ݒ� %%%
parameter.dx = 0.0005; %�Z���T�C�Y(x��)
parameter.dy = 0.0005; %�Z���T�C�Y(y��)
%%% ���̑g�D�̃p�����[�^�ݒ�(�ؓ�) %%%
parameter.p = 1040; %���̖̂��x[kg/m^3]
parameter.c = 3600; %���̂̔�M[J/kg�E��]
parameter.k = 0.50; %���̂̔M�`����[W/m�E��]
parameter.A = 690; %��ӔM�̐ݒ�[W/m^3]
%%% ���t�̃p�����[�^ %%%
parameter.b = 2700; %�����萔�̐ݒ�[W/m^3�Ek](b=p*pb*cb*F)���ؓ��̂��̂ɕύX
parameter.Tb = 37.0; %���t�̉��x
%%% �@��̔M���l���邽�߂̃p�����[�^�ݒ� %%%
parameter.thermalsend = 30; %���M���̋@��̔M[W]
parameter.thermalcooling = 0.1;

%%%%%%%%%% MAC�w�̒�` �S�ĕb�ɒ����Ă��� %%%%%%%%%%
bit.dataframe = 8*(7+255+2); % header:7,data:255,FCS:2 octet
bit.IACK = 8*3  ; % 3octets
slottime = 0.009; % ALOHA�X���b�g�̒������f���[�e�B��3.125%�̎��̂Q�{�ƒ�`����Ɗy
slotlength = 10; % �X���b�g��
tdma = 0; % �n�_a�̂��߂̊��蓖�ăm�[�h
%%%%%%%%%% ���s�� �����̃X�[�p�[�t���[�����J��Ԃ��̂� %%%%%%%%%%
temperature_count = 10000; % �ύX/�X���[�v�b�g�̕��ς���邽�߂Ɏ��s�񐔂𑽂����Ă���.slotlength�����������Ƃ�10000�ōō��ɂ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% ��ɕύX�����Ă����l %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% ���x�ɂ��� %%%%%%%%%%
for i = 1:settingplace
    
    %%%%% ����x�̐ݒ� %%%%%
    if (i == 1)
        place(i).criterion = 37.3;
    else
        place(i).criterion = 0;
    end
    
    place(i).T = zeros(sellnumber,sellnumber); % �ݒu�����Ƃ̉��x
    if i == 1
        place(i).temperature = place(i).criterion; % �e�ݒu�ꏊ�̏�����&�ő�l�Ƃ���D
    else
        place(i).temperature = 37;
    end
    place(i).T(:,:) = place(i).temperature; % �����l�̐ݒ�
    %%%%% �p���X�̃f���[�e�B�� %%%%%
    %%%%% �ȒP�̂��߂ɐݒu�ꏊ�Ńp���X�̃f���[�e�B������Ƃ��� %%%%%
    place(i).duty = 3.125;% �ύX(������x%�ŕ\������)
    place(i).duty = place(i).duty/3.125; % 3.125% = 1�Ƃ��Ă���(�L������̒�`���Q�l�ɂ���)
    
    %%%%% �p�P�b�g�̑��M���� %%%%%
    [place] = packettime(place,bit,i);
    
    %%%%% �ݒu�ꏊ�̏�� %%%%%
    %%%%% 1:�������x 2:37.3�x�𒴂�����(�}�[�W�����C��) 3:37.5�x�𒴂�����(�f���W�����X�]�[��) %%%%%
    place(i).state = 1;
    
    %%%%% ���M�Ԋu�ύX���� %%%%%
    place(i).sendintervalchangetime = 0.09;
    
    %%%%% ���M�Ԋu�̐��� %%%%%
    place(i).int = 1;
    
    %%%%% �̉��̃o�b�t�@ %%%%%
    place(i).temperaturebuffer = 0;
    
    %%%%% 臒l�𒴂��Ă������� %%%%%
    place(i).overtime = 0;
    
    %%%%% ���x��臒l��A�����Ē����Ă����ő�̎��� %%%%%
    place(i).maxsuccessiveovertime = 0;
    
    %%%%% �S�̂̃V�~�����[�V�������Ԃɑ΂��āC臒l�𒴂��Ă������Ԃ̊��� %%%%%
    place(i).overtimeparcent = 0;
    
    %%%%% ���M�Ԋu�ύX���� %%%%%
    place(i).changeinterval = place(i).sendintervalchangetime;
end

%%%%%%%%%% �p�P�b�g�ɂ��� %%%%%%%%%%
for j = 1:totalnode
    %%%%% �e�m�[�h�̏�� %%%%%
    %%% 0:�p�P�b�g�������Ă��Ȃ��@1:�p�P�b�g�������Ă���@2:�p�P�b�g������C���M����^����ꂽ��ԁ@3:���M���@4:���M�����@5:���M���s�@
    node(j).state = 0;
    
    %%%%% ���M�܂ł̎c��҂����� %%%%%
    node(j).waittime = j/node(j).offeredload; % �R���e���V�������N���������̑҂�����
    
    %%%%% �p�P�b�g�����N����܂ł̎c�莞�ԁ@���N�p�x�������_�� %%%%%
    node(j).passtime = 1/node(j).offeredload;
    
    %%%%% �p�P�b�g�̑��M�Ԋu %%%%%
    node(j).interval = 1/node(j).offeredload;
    
    %%%%% �p�P�b�g�̐��N�� %%%%%
    %%%%% ���M������ + �p���� + ���ݎ����Ă���p�P�b�g(0 or 1) %%%%%
    node(j).generation = 0;
    
    %%%%% �p�P�b�g�̑��M������ %%%%%
    node(j).succession = 0;
    
    %%%%% �p�P�b�g�̔p���� %%%%%
    node(j).disposal = 0;
    
    %%%%% �p�P�b�g�̑��M�� %%%%%
    node(j).transmission = 0;
    
    %%%%% �e�m�[�h�̃X���[�v�b�g %%%%%
    node(j).throughput = 0;
    
    %%%%% �p�P�b�g�̃R���e���V������ %%%%%
    node(j).contention = 0;
    
    %%%%% ���݂̒x������ %%%%%
    node(j).delaytime = 0;
    
    %%%%% ���ϒx������ %%%%%
    node(j).meandelay = 0;
    
    %%%%% �Œ�x������ %%%%%
    node(j).worstdelaytime = 0;
    
    %%%%% �x���� %%%%%
    node(j).maxdelay = 0.25;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% ���̑� %%%%%%%%%%
%%%%% ���݂̌o�ߎ��Ԍv�Z�ϐ� %%%%%
count = 1; % 1�͏����l�Ɋւ��邱�Ƃ�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% �L�^����l %%%%%%%%%%%%%%%
%%%%%%%%%% ���x %%%%%%%%%%
%%%%% �m�[�h1�ƃm�[�h2�͓������ɂ���̂ŁC�ۑ��l��1���Ȃ� %%%%%
register = zeros(settingplace+1,temperature_count+1);
%%%%% �e�m�[�h���̉��x�����l %%%%%
for i = 1:settingplace
    register(i+1,1) = place(i).temperature;
end
h = waitbar(0,'Please wait'); %waitbar��ݒu
for i = 1:temperature_count
    for j = 1:slotlength
        %%%%% S-ALOHA�ɂ��� %%%%%
        [register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace);
    h = waitbar(((i-1)*slotlength+j)/(temperature_count*slotlength));
    end
end

for i = 1:settingplace
   place(i).overtimeparcent = place(i).overtime/(temperature_count*slottime);
end

for i = 1:totalnode
   node(i).meandelay = node(i).meandelay/node(i).succession; 
end
close(h)