figure('position',[-1851, 345, 895, 420]);
hObj=nan(3,1);
hObj(1)=scatter([1:366],100*dustSurfRSDDayOfYearHATS,'k','filled');
hold on;
extendedData=[dustSurfRSDDayOfYearHATS(end-4:end);dustSurfRSDDayOfYearHATS;dustSurfRSDDayOfYearHATS(1:5)];
hObj(2)=plot([1:366],100*movmean(extendedData,[5,5],"Endpoints","discard"),'r','linewidth',2);
extendedData=[dustSurfRSDDayOfYearHATS(end-14:end);dustSurfRSDDayOfYearHATS;dustSurfRSDDayOfYearHATS(1:15)];
hObj(3)=plot([1:366],100*movmean(extendedData,[15,15],"Endpoints","discard"),'b','linewidth',2);

legend(hObj,{'RSD of Dust at each Day of Year','+/- 5-day moving mean','+/- 15-day moving mean'});
ylabel('RSD of Dust Surface (%)');
xlabel('Day of Year');


xlim([1 366]);
hAx1=gca;
set(hAx1, 'Box', 'off');
monthStarts = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335];
hAx2=axes('Position',hAx1.Position,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
set(hAx2, 'XLim', [1, 366], 'XTick', monthStarts, 'XTickLabelRotation',45,'XTickLabel', ...
    {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
set(hAx2, 'YTick', []);
uistack(hAx1,'top');
set(hAx1,'color','none','position',[0.1300, 0.1257, 0.7750, 0.7124]);
set(hAx2,'position',get(hAx1,'position'));
grid on;

saveas(gcf,'./Figures/RSDofDust_OverTime.png');
saveas(gcf,'./Figures/RSDofDust_OverTime.fig');

clear hAx1 hAx2 hObj i monthStarts tc ans