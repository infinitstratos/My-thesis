figure(1)
for i = 2:4
   plot(temperature2(1,1:100000),temperature2(i,1:100000));
   hold on
end
xlabel('���� [s]')
ylabel('���x [��]')
title('�n�_b�̉��x�̎��Ԑ���')
legend('�ύX�Ȃ�','�K���I�ɕω�A','�K���I�ɕω�B')

figure(2)
throughput = [throughput2];
bar(throughput)

set(gca,'Xticklabel',{'�ύX�Ȃ�','�K���I�ɕω�A','�K���I�ɕω�B'})
ylabel('�X���[�v�b�g [kbps]')
title('�n�_b�̊e��Ԃ̃X���[�v�b�g')