figure('position',[81   589   620   420]);
hAx1=gca;
scatter(1:366,precipSurfMeanDayOfYearALOHA,10,'b');
hold on;
hLine1=plot(1:366,movmean(precipSurfMeanDayOfYearALOHA,[10,10]),'b');
xlabel(hAx1,'Day of Year');
ylabel(hAx1,{'Precip (ALOHA), daily mean','[kg m^{-2} s^{-1}]'});
hAx1.YAxis.Color='b';
ylim(hAx1,[0 .5e-4]);

hAx2=axes('position',get(gca,'position'));
scatter(1:366,dustSurfMedianDayOfYearHATS,10,'r');
hold on;
hLine2=plot(1:366,movmean(dustSurfMedianDayOfYearHATS,[5,5]),'r');
hAx2.YLabel.Rotation=270;
hAx2.YAxis.Color='r';
ylabel(hAx2,{'Dust (whole domain), daily median','[kg m^{-3}]'});

legend([hLine1,hLine2],{'Precip (±10d movmean)','Dust (±5d movmean)'});
set(hAx2,'color','none','YAxisLocation','right');
set([hAx1 hAx2],'xlim',[0 366],'position',[ 0.1300    0.1548    0.7071    0.7702]);

saveas(gcf,'./Figures/DustAndPrecipSeasonality.png');
saveas(gcf,'./Figures/DustAndPrecipSeasonality.png');

clear hAx2 hAx1 hLine1 hLine2