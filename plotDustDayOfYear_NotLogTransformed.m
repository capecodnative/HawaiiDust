figure('position',[-2927, 51, 700, 464]);
scatter([1:366],dustSurfMedianDayOfYearHATS,'k','filled')
hold on;
plot([1:366],movmean(dustSurfMedianDayOfYearHATS,[5,5]),'r','linewidth',2);
xlim([1 366]);
hAx1=gca;
set(hAx1, 'Box', 'off','color','none','position',[0.1300, 0.1100, 0.7750, 0.6924]);
xlabel('Day of Year');
ylabel({'Median Surface Dust','(Linear Scale) [kg/m^3]'});

monthStarts = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335];
hAx2=axes('Position',[0.1300, 0.1100, 0.7750, 0.7519],...
'XAxisLocation','top',...
'YAxisLocation','right',...
'Color','none');
set(hAx2, 'XLim', [1, 366], 'XTick', monthStarts, 'XTickLabelRotation',45,'XTickLabel', ...
{'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
set(hAx2, 'YTick', []);
uistack(hAx1,'top');
grid on;
uistack(hAx2,'top');

hAx3=axes('position',[0.6071    0.2759    0.2971    0.5345],'color','none');
scatter(hAx3,[1:366],dustSurfMedianDayOfYearHATS,'k','filled')
hold on;
plot(hAx3,[1:366],movmean(dustSurfMedianDayOfYearHATS,[5,5]),'r','linewidth',2);
xlim([225,366]);
ylim([2e-10 5.5e-10]);
set(hAx3,'color','none','box','off');
xticks([]);

saveas(gcf,'./Figures/HATS_MedianDustSurf_NOTlog-transformed.png');
saveas(gcf,'./Figures/HATS_MedianDustSurf_NOTlog-transformed.fig');

clear hAx* monthStarts