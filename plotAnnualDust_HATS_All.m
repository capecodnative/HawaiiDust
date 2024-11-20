hLeg=nan(3,1);
hFig=figure('position',[1054, 917, 1426, 420]);
for i=1980:2023
    tc=finalDustTableHATS.Year==i;
    tempY=finalDustTableHATS.DustSurfMedian(tc);
    hLeg(1)=plot(finalDustTableHATS.Date(tc),tempY,'k','linewidth',1);
    hold on;
    scatter(finalDustTableHATS.Date(tc),tempY,5,'k');
    hLeg(2)=plot(finalDustTableHATS.Date(tc),movmean(tempY,[10 0]),'color','b','linewidth',1.5);
    tempX=datetime(i,1,1):caldays(1):datetime(i+1,1,1);
    hLeg(3)=plot(tempX(1:size(tempY,1)),dustSurfMedianDayOfYearHATS(1:size(tempY,1)),'color','r','linewidth',1);
    legend(hLeg,{sprintf('Median Daily Surface Dust %d',i),'10 Day Lagging Mean','Multi-year Median (1980-2023)'});
    tempName=sprintf('./Figures/AnnualDust/AnnualDustAtSurf_HATS_WholeDomain_%4d.',i);
    xticks([datetime(i,1,1):calmonths(1):datetime(i+1,1,1)])
    title(sprintf('Daily Dust at Surface, Whole Domain, %4d',i));
    savefig(hFig,strcat(tempName,'fig'));
    saveas(hFig,strcat(tempName,'png'));
    clf;
end
close(hFig);

clear hFig hLeg i tc tempName tempX tempY
