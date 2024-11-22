cmap=jet(256);
zmap=linspace(1980,2024,length(cmap));
figure('position',[31   336   808   420]);
hLegend=nan(2,1);

for i=1980:2023
    tc=finalDustTableHATS.Year==i;
    %toPlotY=cumsum(finalDustTableHATS.DustSurfMedian(tc))./sum(finalDustTableHATS.DustSurfMedian(tc));
    %toPlotY=cumsum(finalDustTableHATS.DustSurfMedian(tc));
    toPlotY=dustDaysSortedNormCumSum(:,i-1979);
    tempLinewidth=1;
    tempColor=interp1(zmap,cmap,i);
    tempLineStyle='-';
    if i==2022 || i==2023
        tempLinewidth=2;
        tempColor='k';
        if i==2023
            tempLineStyle=':';
        end
    end
    hPlot=plot(1:size(toPlotY,1),toPlotY,'color',tempColor,'linestyle',tempLineStyle,'linewidth',tempLinewidth);
    if i==2022 || i==2023
        hLegend(i-2021)=hPlot;
    end
    hold on;
end

xlim([1,366]);
xlabel('Rank-Sorted Days of Each Year (1 = Dustiest Day)');
%ylabel('% of Annual Cumulative Dust at Surface');
ylabel({'Cumulative Fraction of','Annual Dust at Surface'});
legend(hLegend,{'2022','2023'},'Location','Northwest' );
colorbar;
colormap(jet);
clim([1980,2023])

hAx1=gca;
set(hAx1, 'Box', 'off');

xlim([0 100]);
xticks([0:10:90]);

hLine=hline(0.5);
hLine.LineWidth=2;
hLine.LineStyle='-';
vLine1=vline(82);
text(49,0.1,{'Day 49'});
text(82,0.1,{'Day 82'});
hLine.Color=[0.3,0.3,0.3];
box on;
vLine1.Color=[0.3,0.3,0.3];
vLine2=vline(49);
vLine2.Color=[0.3,0.3,0.3];
ylim([0 0.75]);
vLine2.LineWidth=1.75;
vLine1.LineWidth=1.75;

saveas(gcf,'./Figures/RankedDaysCumDust-LinearZoom.fig');
saveas(gcf,'./Figures/RankedDaysCumDust-LinearZoom.png');

clear hLine vLine1 vLine2
clear i tc tempSumDust toPlotY monthStarts tempLinewidth tempLineStyle tempColor hAx2 hAx1 zmap cmap hLegend hPlot