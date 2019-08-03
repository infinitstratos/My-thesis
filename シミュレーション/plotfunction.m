figure(1)
for i = 2:4
   plot(temperature2(1,1:100000),temperature2(i,1:100000));
   hold on
end
xlabel('時間 [s]')
ylabel('温度 [℃]')
title('地点bの温度の時間推移')
legend('変更なし','適応的に変化A','適応的に変化B')

figure(2)
throughput = [throughput2];
bar(throughput)

set(gca,'Xticklabel',{'変更なし','適応的に変化A','適応的に変化B'})
ylabel('スループット [kbps]')
title('地点bの各状態のスループット')