tempXvars={corrMonthlyPDO,corrMonthlyPDO,corrMonthlyNino,corrMonthlyNino};
tempYvars={corrMonthlyPrecip,corrMonthlyDust,corrMonthlyPrecip,corrMonthlyDust};
tempXlabels={'PDO','PDO','NINO4','NINO4'};
tempYlabels={'PrecipAnom','DustAnom','PrecipAnom','DustAnom'};
tempFilenames={'PDO_PrecipAnom','PDO_DustAnom','NINO_PrecipAnom','NINO_DustAnom'};
hLine=nan(2,1);
tempCoeffsR2P=nan(size(tempYvars,2),12,3);
figure;

for k=3:size(tempYvars,2)

for i=1:12
    tc=[i:12:528];
    tempLM=fitlm(tempXvars{k}(tc),tempYvars{k}(tc),'RobustOpts','on');
    h=plot(tempLM);
    hLine(1)=hline(0);
    hLine(2)=vline(0);
    set(hLine,'linewidth',1.5,'color','k');
    xlabel(tempXlabels{k});
    ylabel(tempYlabels{k});
    h(1).Marker='o';
    h(1).MarkerEdgeColor='b';
    h(1).MarkerFaceColor='b';
    h(2).Color='r';
    h(2).LineWidth=2;
    h(3).Color='r';
    h(3).LineWidth=2;
    coeffs = tempLM.Coefficients.Estimate;
    rSquared = tempLM.Rsquared.Ordinary;
    pValues = tempLM.Coefficients.pValue;
    tempCoeffsR2P(k,i,1)=coeffs(2);
    tempCoeffsR2P(k,i,2)=rSquared;
    tempCoeffsR2P(k,i,3)=pValues(2);
    equationString = sprintf('Slope: %.3g\nR^2 = %.3g p(Slope) = %.3g', ...
     coeffs(2), rSquared, pValues(2));
    dim = [0.15 0.8 0.3 0.1]; % Adjust left and bottom as necessary
    hText=annotation('textbox', dim, 'String', equationString, 'FitBoxToText', 'on', 'BackgroundColor', 'none', 'VerticalAlignment', 'top');
    
    
    title(sprintf('%s vs %s, month=%02d',tempXlabels{k},tempYlabels{k},i));
    legend off;
    saveas(gcf,sprintf('./Figures-CorrAnalysis/%s_Month-%d.png',tempFilenames{k},i));
    saveas(gcf,sprintf('./Figures-CorrAnalysis/%s_Month-%d.fig',tempFilenames{k},i));
    clf;
end

end

clear tempXlabels tempXvars tempYlabels tempYvars tempFilenames hLine h i k tc tempLM hPlot