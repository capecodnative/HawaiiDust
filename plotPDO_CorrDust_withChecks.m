tempFig=figure('position',[-1778, 402, 612, 435]);
tempFig2=figure('position',[ -1564, 20, 1088, 727]);
tempXVar=corrDailyPDO;
tempXVarLabel={'PDO'};
tempXVarShortname={'PDO'};
tempFilter=corrDailyMonthNoVolc;

tempYVars={corrDailyDust30, corrDailyPrecip30,...
    HATSDustSurfMedianDayNormed,corrDailyDustZMonth,PrecipAlohaMedianSubtracted,corrDailyPrecipZMonth};
tempYVarShortname={'DustDaily', 'DailyPrecip', 'DailyPrecip'...
    'DailyDustAnom_noMovmean','DailyDustAnom_NoMovmean_ZMonth','DailyPrecipAnom_noMovmean','DailyPrecipAnom_NoMovmean_ZMonth'};
tempYVarLabels={{'Daily Surf Dust Anomaly', '30d moving mean (kg/m3)'}, {'Daily Surf Dust Zscore', '30d moving mean'}, {'Daily Surf Precip Anomaly', '30d moving mean'}, {'Daily Surf Precip ZScore', '30d moving mean'}...
    {'Daily Surf Dust Anomaly', '(kg/m3)'}, {'Daily Surf Dust Anom','Monthly Zscore'}, {'Daily Surf Precip Anomaly'}, {'Daily Surf Precip Anomaly', '(monthly ZScore)'}};
tempCoeffsR2P=nan(4,12,3);

for j=[5:8]
    tempYVar=tempYVars{j};
    for i=1:12
        tc=tempFilter==i;
        figure(tempFig);
        tempLM=fitlm(tempXVar(tc),zscore(tempYVar(tc)));
        plot(tempLM);
        vline(0,'r-');
        hline(0,'r-');
        title(sprintf('%s vs %s, Month=%d', tempYVarShortname{j}, tempXVarShortname{1}, i));

        coeffs = tempLM.Coefficients.Estimate;
        rSquared = tempLM.Rsquared.Ordinary;
        pValues = tempLM.Coefficients.pValue;
        tempCoeffsR2P(j,i,1)=coeffs(2);
        tempCoeffsR2P(j,i,2)=rSquared;
        tempCoeffsR2P(j,i,3)=pValues(2);

        legend off;
        xlabel(tempXVarLabel{1});
        ylabel(tempYVarLabels{j});
        equationString = sprintf('Slope: %.3g\nR^2 = %.3g p(Slope) = %.3g', coeffs(2), rSquared, pValues(2));

        dim = [0.15, 0.8, 0.3, 0.1];
        annotation('textbox', dim, 'String', equationString, 'FitBoxToText', 'on', 'BackgroundColor', 'none', 'VerticalAlignment', 'top');

        % Additional statistical checks in a second figure
        figure(tempFig2);
        tiledlayout(2, 2); % 2x2 layout for assumption checks

        % Linearity: Residual Plot
        nexttile;
        plotResiduals(tempLM, 'fitted');
        title('Residuals vs Fitted (Linearity Check)');

        % Independence: Durbin-Watson Test
        residuals = tempLM.Residuals.Raw;
        [dwStat, p_dw] = dwtest(tempLM);
        nexttile;
        text(0.1, 0.5, sprintf('Durbin-Watson: %.3f\np = %.3g', dwStat, p_dw), 'FontSize', 12);
        title('Independence Check (Durbin-Watson Test)');
        axis off;

        % Homoscedasticity: Breusch-Pagan Test
        n = length(residuals); % Number of observations
        residualsSquared = residuals.^2;
        tempLM_BP = fitlm(tempXVar(tc), residualsSquared);
        rSquared_BP = tempLM_BP.Rsquared.Ordinary;

        % Breusch-Pagan statistic
        BP_stat = n * rSquared_BP;
        p_bp = 1 - chi2cdf(BP_stat, 1); % df = 1 for a single predictor model

        % Plotting results in the diagnostic window
        nexttile;
        plotResiduals(tempLM, 'fitted');
        title(sprintf('Homoscedasticity (Breusch-Pagan p = %.3g)', p_bp));


        % Normality: Q-Q Plot of Residuals
        nexttile;
        qqplot(residuals);
        title('Normality of Residuals (Q-Q Plot)');

        pause; % Allows for viewing each figure output separately
        % Save the figure plot if necessary
        tempName=sprintf('./Figures/HATS_corr_%s_%s_Month%02d_checks.', tempYVarShortname{j}, tempXVarShortname{1}, i);
        saveas(tempFig2, strcat(tempName, 'png'));
        clf(tempFig2); % Clear figure 2 for next iteration

        % Save the original plot if necessary
        tempName=sprintf('./Figures/HATS_corr_%s_%s_Month%02d.', tempYVarShortname{j}, tempXVarShortname{1}, i);
        saveas(tempFig, strcat(tempName, 'png'));
        clf(tempFig);
    end
end
