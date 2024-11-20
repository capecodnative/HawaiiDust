figure('Position',[ -1787, 340, 895, 420]);
hObj=nan(4,1);

scatter(1980:2023,tempStats10152025(:,1),'k','filled');
hold on;
hObj(4)=plot(1980:2023,tempStats10152025(:,1),'k','linewidth',1.5);
scatter(1980:2023,tempStats10152025(:,2),'b','filled');
hObj(3)=plot(1980:2023,tempStats10152025(:,2),'b','linewidth',1.5);
scatter(1980:2023,tempStats10152025(:,3),'r','filled');
hObj(2)=plot(1980:2023,tempStats10152025(:,3),'r','linewidth',1.5);
scatter(1980:2023,tempStats10152025(:,4),'g','filled');
hObj(1)=plot(1980:2023,tempStats10152025(:,4),'g','linewidth',1.5);
ylabel({'Day of Year "n"-th','Percentile Crossed'});
xlim([1980 2024]);
ylim('auto');
legend(hObj,{'25%','20%','15%','10%'})

saveas(gcf,'./Figures/HATS_NthPercentileDay_Allpct.fig')
saveas(gcf,'./Figures/HATS_NthPercentileDay_Allpct.png')
clear hObj