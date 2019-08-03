%%%%%%%%%% 試行回数 いくつのスーパーフレームを繰り返すのか %%%%%%%%%%
temperature_count = 50000; % 変更/スループットの平均を取るために試行回数を多くしている
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% 記録する値 %%%%%%%%%%%%%%%

h = waitbar(0,'Please wait'); %waitbarを設置
for i = 1:temperature_count
    %%%%% S-ALOHAについて %%%%%
    [register,count,node,place] = SlottedALOHA(register,count,sellnumber,totalnode,SAR,parameter,slottime,node,bit,place,settingplace);
    h = waitbar(i/temperature_count);
end
close(h)