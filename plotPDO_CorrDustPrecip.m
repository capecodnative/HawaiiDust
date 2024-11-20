tempFig=figure('position',[-1778         402         612         435]);
tempXVar=corrDailyPDO;
tempXVarLabel={'PDO (daily)'};
tempXVarShortname={'PDO'};
tempFilter=corrDailyMonthNoVolc;
tempYVarShortname={'DailyDust_fixed';'DailyDustZ';'DailyPrecip_fixed';'DailyPrecipZ'};
tempYVarLabels={{'Daily Surf Dust Anomaly';'30d moving mean (kg/m3)'};{'Daily Surf Dust Zscore';'30d moving mean'};{'Daily Surf Precip Anomaly';'30d moving mean'};{'Daily Surf Precip figuZScore';'30d moving mean'}};
tempYVars={corrDailyDust30;corrDailyDustZ30;corrDailyPrecip30;corrDailyPrecipZ30};
tempCoeffsR2P=nan(4,12,3);

for j=1:4
    tempYVar=tempYVars{j};
for i=1:12
    tc=tempFilter==i;
    tempLM=fitlm(tempXVar(tc),tempYVar(tc));
    plot(tempLM);
    %if j==1
    %    ylim([-1.2e-9 2.5e-9]);
    %elseif j==3
    %    ylim([-1e-5 8e-5]);
    %end
    %xlim([-3.1 3.1]);
    vline(0,'r-');
    hline(0,'r-');
    title(sprintf('%s vs %s, Month=%d',tempYVarShortname{j},tempXVarShortname{1},i));
    coeffs = tempLM.Coefficients.Estimate;
    rSquared = tempLM.Rsquared.Ordinary;
    pValues = tempLM.Coefficients.pValue;
    tempCoeffsR2P(j,i,1)=coeffs(2);
    tempCoeffsR2P(j,i,2)=rSquared;
    tempCoeffsR2P(j,i,3)=pValues(2);

    legend off;
    xlabel(tempXVarLabel{1});
    ylabel(tempYVarLabels{j});
    equationString = sprintf('Slope: %.3g\nR^2 = %.3g p(Slope) = %.3g', ...
     coeffs(2), rSquared, pValues(2));

    dim = [0.15 0.8 0.3 0.1]; % Adjust left and bottom as necessary
    hText=annotation('textbox', dim, 'String', equationString, 'FitBoxToText', 'on', 'BackgroundColor', 'none', 'VerticalAlignment', 'top');
    %pause;
    tempName=sprintf('./Figures/HATS_corr_%s_%s_Month%02d.',tempYVarShortname{j},tempXVarShortname{1},i);
    %savefig(tempFig,strcat(tempName,'fig'));
    saveas(tempFig,strcat(tempName,'png'));
    clf;
end
end