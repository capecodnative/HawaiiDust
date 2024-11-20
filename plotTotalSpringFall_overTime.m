figure('Position',[-1722, 314, 725, 420]);
hObj=nan(3,1);
hObj(1)=scatter(1980:2023,sum(dustDaysSorted,1,'omitmissing'),'filled','k');
hold on;
plot(1980:2023,sum(dustDaysSorted,1,'omitmissing'),'k','linewidth',1.5);
xlim([1980 2024]);

hObj(2)=scatter(1980:2023,sumSpringDust,'r','filled');
plot(1980:2023,sumSpringDust,'r','linewidth',1.5);

hObj(3)=scatter(1980:2023,sumFallDust,'b','filled');
plot(1980:2023,sumFallDust,'b','linewidth',1.5);
ylabel('Total Dust Over Site (kg/m^3)');xlabel('Year');
xlim([1980 2024]);
legend(hObj,{'Annual','Spring (Feb-July)','Fall (Aug-Jan)'});
saveas(gcf,'./Figures/HATS_TotalDustOverSite.fig');
saveas(gcf,'./Figures/HATS_TotalDustOverSite.png')

clear hObj;