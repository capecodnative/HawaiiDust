cmap=jet(256);
zmap=linspace(1980,2024,length(cmap));
figure('Position',[-1900, 263, 1096, 549]);
hLegend=nan(2,1);
tempStats10152025=nan(2024-1980,4);
tempPositions=[0.1, 0.15, 0.2, 0.25];

for i=1980:2023
    tc=finalDustTableHATS.Year==i;
    %toPlotY=cumsum(finalDustTableHATS.DustSurfMedian(tc))./sum(finalDustTableHATS.DustSurfMedian(tc));
    toPlotY=cumsum(finalDustTableHATS.DustSurfMedian(tc));
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
    for j=1:4
        [~,tempStats10152025(i-1979,j)]=min(abs(toPlotY-tempPositions(j)));
    end
end

xlim([1,366]);
xlabel('Day of Year');
%ylabel({'Fractional Cumulative','Dust at Surface'});
ylabel({'Cumulative Dust','at Surface (kg/m^3)'});
legend(hLegend,{'2022','2023'},'Location','Northwest' );
hColorbar=colorbar;
colormap(jet);
clim([1980,2023]);
yticks([0:1e-7:6e-7]);

hAx1=gca;
set(hAx1, 'Box', 'off','YGrid','on');
monthStarts = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335];
hAx2=axes('Position',hAx1.Position,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
set(hAx2, 'XLim', [1, 366], 'XTick', monthStarts, 'XTickLabelRotation',45,'XTickLabel', ...
    {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
set(hAx2, 'YTick', []);
grid on;

saveas(gcf,'./Figures/CumulativeDust_AllYears.fig');
saveas(gcf,'./Figures/CumulativeDust_AllYears.png');

clear j tc tempFig tempName tempSumDust toPlotY monthStarts tempLinewidth tempLineStyle tempColor hAx2 hAx1 hColorbar i hLegend tempStats10152025 tempPositions zmap cmap hPlot
