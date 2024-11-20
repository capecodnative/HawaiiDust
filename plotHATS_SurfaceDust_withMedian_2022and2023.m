figure;
tempColors={'b','r','g'};
cruiseDates=NaT(6,1);
cruiseDates(1)=datetime(2022,05,29);
cruiseDates(2)=datetime(2022,09,1);
cruiseDates(3)=datetime(2023,01,24);
cruiseDates(4)=datetime(2023,03,28);
cruiseDates(5)=datetime(2023,05,25);
cruiseDates(6)=datetime(2023,08,10);

hLines=nan(5,1);
for i=2022:2024
    tc=finalDustTableHATS.Year==i;
    scatter(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian_ALOHA(tc)),10,tempColors{i-2021});
    hold on;
    hLines(i-2021)=plot(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian_ALOHA(tc)),...
        'linewidth',1,'color',tempColors{i-2021});
end
for i=1:6
    tc=finalDustTableHATS.Year==cruiseDates(i).Year & finalDustTableHATS.Month==cruiseDates(i).Month & finalDustTableHATS.Day==cruiseDates(i).Day;
    hLines(5)=scatter(finalDustTableHATS.DayOfYear(tc),log10(finalDustTableHATS.DustSurfMedian_ALOHA(tc)),80,...
        tempColors{finalDustTableHATS.Year(tc)-2021},'filled','markeredgecolor','k','linewidth',2);
end
hLines(4)=plot([1:366],log10(movmean(dustSurfMedianDayOfYearHATS_ALOHA,[7,7])),'k-','linewidth',2);
xlim([0 367]);
legend(hLines,{'2022','2023','2024','Median, 7D, All Yrs','HATS Cruises'});