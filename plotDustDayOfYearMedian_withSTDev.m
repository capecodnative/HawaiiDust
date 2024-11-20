figure('position',[-1829, 284, 939, 515]);
scatter(finalDustTableHATS.DayOfYear,log10(finalDustTableHATS.DustSurfMedian),10,finalDustTableHATS.Year);
hold on;
hColorbar=colorbar;
colormap parula;
tempX=1:366;
hLines=nan(3);
hLines(1)=plot(tempX,log10(movmean(dustSurfMedianDayOfYearHATS,[5,5])),'r-','linewidth',2);
hLines(2)=plot(tempX,log10(movmean(dustSurfMedianDayOfYearHATS,[5,5]))+movmean(dustSurfLogSTDDayOfYearHATS,[5,5]),'r--','linewidth',1);
hLines(3)=plot(tempX,log10(movmean(dustSurfMedianDayOfYearHATS,[5,5]))-movmean(dustSurfLogSTDDayOfYearHATS,[5,5]),'r--','linewidth',1);
xlim([0 367]);
xlabel('Day of Year');
ylabel('log_{10} Dust at Surface (kg/m^3)');
title({'Median Daily Surface Dust between 15 to 28ºN and -165 to -150ºE';'1980-2024 MERRA2'},'position',[182.4476   -7.0429         0]);

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
set(hAx1,'color','none');
grid on;

legend([hLines(1),hLines(2)],{'Day-of-Year Median, (± 5d smoothed)','+/- 1 s.d., (± 5d smoothed)'});
set(hAx2,'position',[0.1239, 0.1100, 0.7386, 0.7055]);
set(hAx1,'position',get(hAx2,'Position'));
saveas(gcf,'./Figures/HATS_DustSurf_WholeDomain_1980-to-2024.fig')
saveas(gcf,'./Figures/HATS_DustSurf_WholeDomain_1980-to-2024.png')

clear hAx1 hAx2 hColorbar hLines tempX monthStarts
