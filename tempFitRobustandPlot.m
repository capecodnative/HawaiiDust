tempX=corrDailyPDO;
tempY=corrDailyPrecip30;

tempLM=fitlm(tempX,tempY,"RobustOpts","on");
%tempLM=fitlm(tempX,tempY);
clf;
plot(tempLM);

vline(0,'r-');
hline(0,'r-');

coeffs = tempLM.Coefficients.Estimate;
rSquared = tempLM.Rsquared.Ordinary;
pValues = tempLM.Coefficients.pValue;
tempCoeffsR2P(j,i,1)=coeffs(2);
tempCoeffsR2P(j,i,2)=rSquared;
tempCoeffsR2P(j,i,3)=pValues(2);

legend off;
%xlabel(tempXVarLabel{1});
%ylabel(tempYVarLabels{j});
equationString = sprintf('Slope: %.3g\nR^2 = %.3g p(Slope) = %.3g', coeffs(2), rSquared, pValues(2));

dim = [0.15, 0.8, 0.3, 0.1];
annotation('textbox', dim, 'String', equationString, 'FitBoxToText', 'on', 'BackgroundColor', 'none', 'VerticalAlignment', 'top');
