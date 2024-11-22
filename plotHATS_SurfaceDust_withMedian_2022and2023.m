figure('position',[96, 448, 948, 420]);
tempColors={'b','r'};
cruiseDates=NaT(6,1);
cruiseDates(1)=datetime(2022,05,29);
cruiseDates(2)=datetime(2022,09,1);
cruiseDates(3)=datetime(2023,01,24);
cruiseDates(4)=datetime(2023,03,28);
cruiseDates(5)=datetime(2023,05,25);
cruiseDates(6)=datetime(2023,08,10);

hLines=nan(4,1);
for i=2022:2023
    tc=finalDustTableHATS.Year==i;
    scatter(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian(tc)),10,tempColors{i-2021});
    hold on;
    hLines(i-2021)=plot(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian(tc)),...
        'linewidth',1,'color',tempColors{i-2021});
end
for i=1:6
    tc=finalDustTableHATS.Year==cruiseDates(i).Year & finalDustTableHATS.Month==cruiseDates(i).Month & finalDustTableHATS.Day==cruiseDates(i).Day;
    hLines(4)=scatter(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian(tc)),80,...
        tempColors{finalDustTableHATS.Year(tc)-2021},'filled','markeredgecolor','k','linewidth',2);
end
hLines(3)=plot([1:366],log10(dustSurfMedianDayOfYearHATS10),'k-','linewidth',2);
xlim([0 367]);
xlabel('Day of Year');
ylabel({'log_{10} Daily Dust at Surface (kg/m^3)'});

legend(hLines,{'2022','2023','Multiyear Median (±5d-smoothed), All Yrs','HATS Cruises'});
hAx1=gca;
set(hAx1, 'Box', 'off','position',[0.1300, 0.1257, 0.7750, 0.7576]);

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

saveas(gcf,'./Figures/HATS_DustSurf_WholeDomain_2022-to-2023.fig');
saveas(gcf,'./Figures/HATS_DustSurf_WholeDomain_2022-to-2023.png');

clear hAx1 hAx2 hLines i monthStarts tc tempColors cruiseDates