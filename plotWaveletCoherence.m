figurePos=[-1828, 416, 752, 421];
figure('position',figurePos);wcoherence(corrDailyPDO,finalDustTableHATS.DustSurfMedian,years(1/365.25));
title('Coherence PDO(indep) vs DustRaw(dep)');
saveas(gcf,'./Figures/Coherence_PDO_DustRaw.png');
saveas(gcf,'./Figures/Coherence_PDO_DustRaw.fig');

figure('position',figurePos);wcoherence(corrDailyPDO,HATSDustSurfMedianDayNormed,years(1/365.25));
title('Coherence PDO(indep) vs DustAnom(dep)');
saveas(gcf,'./Figures/Coherence_PDO_DustAnom.png');
saveas(gcf,'./Figures/Coherence_PDO_DustAnom.fig');

figure('position',figurePos);wcoherence(corrDailyPDO,finalPrecipTableHATS.PrecipMeanALOHA,years(1/365.25));
title('Coherence PDO(indep) vs PrecipRaw(dep)');
saveas(gcf,'./Figures/Coherence_PDO_PrecipRaw.png');
saveas(gcf,'./Figures/Coherence_PDO_PrecipRaw.fig');

figure('position',figurePos);wcoherence(corrDailyPDO,ALOHAPrecipMeanDayNormed,years(1/365.25));
title('Coherence PDO(indep) vs PrecipAnom(dep)');
saveas(gcf,'./Figures/Coherence_PDO_PrecipAnom.png');
saveas(gcf,'./Figures/Coherence_PDO_PrecipAnom.fig');

figure('position',figurePos);wcoherence(finalPrecipTableHATS.PrecipMeanALOHA,finalDustTableHATS.DustSurfMedian,years(1/365.25));
title('Coherence PrecipRaw(indep) vs. DustRaw(dep)');
saveas(gcf,'./Figures/Coherence_PrecipRaw_DustRaw.png');
saveas(gcf,'./Figures/Coherence_PrecipRaw_DustRaw.fig');

figure('position',figurePos);wcoherence(ALOHAPrecipMeanDayNormed,HATSDustSurfMedianDayNormed,years(1/365.25));
title('Coherence PrecipAnom(indep) vs DustAnom(dep)');
saveas(gcf,'./Figures/Coherence_PrecipAnom_DustAnom.png');
saveas(gcf,'./Figures/Coherence_PrecipAnom_DustAnom.fig');

clear figurePos