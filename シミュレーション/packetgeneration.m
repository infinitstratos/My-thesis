function[node] = packetgeneration(node,totalnode,spendtime) % beacon��������C�t���[�������ς�����肷�邩������Ȃ��̂ŁC�o�ߎ��Ԃ������ɂ��邱��

%%%%% �e�m�[�h�ɂ��ăp�P�b�g���N���v�Z���� %%%%%
for i = 1:totalnode
    %%%%% ���Ԍo�߁C�y�ё҂����Ԃ𑝂₷%%%%%
    node(i).passtime = node(i).passtime - spendtime;
    node(i).waittime = node(i).waittime - spendtime;
    
    %%% �����p�P�b�g�������Ă�����C�x�����Ԃ��v�Z %%%
    if node(i).state == 1
        node(i).delaytime = node(i).delaytime + spendtime;
    end
    %%% �����C���N�܂ł̎c�莞�Ԃ�؂�����p�P�b�g���N %%%
    if node(i).passtime <= 0
      %%% �p�P�b�g�������Ă��Ȃ�������C�x�����Ԃ��v�Z %%% 
      %%% ���̍ہC�p�P�b�g�������Ă�����C�p������ %%%
      if node(i).state == 1
          node(i).disposal = node(i).disposal + 1; % �p����+1
      end
      node(i).state = 1; % �p�P�b�g���N
      node(i).generation = node(i).generation + 1; % �p�P�b�g���N�񐔂𑝂₷
      
      %%% �o�ߎ��Ԃ����Z�b�g %%%
      node(i).passtime = node(i).passtime + 1/node(i).offeredload; % ���̕��@�ł́C�X���b�g����2��ȏ�p�P�b�g���N���������ɂ͎g���Ȃ�
    end
end