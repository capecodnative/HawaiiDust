dustSurfLogSTDDayOfYearHATS=nan(366,1);for i=1:366;tc=finalDustTableHATS.DayOfYear==i;dustSurfLogSTDDayOfYearHATS(i)=std(log10(finalDustTableHATS.DustSurfMedian(tc)),'omitmissing');end;
dustSurfRSDDayOfYearHATS=nan(366,1);for i=1:366;tc=finalDustTableHATS.DayOfYear==i;dustSurfRSDDayOfYearHATS(i)=std(finalDustTableHATS.DustSurfMedian(tc),'omitmissing')/median(finalDustTableHATS.DustSurfMedian(tc),'omitmissing');end;

sumSpringDust=nan(2023-1979,1);for i=1980:2023;tc=finalDustTableHATS.Year==i & finalDustTableHATS.Month>=2 & finalDustTableHATS.Month<=7;sumSpringDust(i-1979)=sum(finalDustTableHATS.DustSurfMedian(tc));end;
sumFallDust=nan(2023-1979,1);for i=1980:2023;tc=finalDustTableHATS.Year==i & (finalDustTableHATS.Month>=8 | finalDustTableHATS.Month<=1);sumFallDust(i-1979)=sum(finalDustTableHATS.DustSurfMedian(tc));end;

%make some dust mean and normalized variables
windowSize=5;
dustSurfMedianDayOfYearHATS10=[dustSurfMedianDayOfYearHATS(end-windowSize+1:end)', dustSurfMedianDayOfYearHATS', dustSurfMedianDayOfYearHATS(1:windowSize)']';
dustSurfMedianDayOfYearHATS10=movmean(dustSurfMedianDayOfYearHATS10,[windowSize,windowSize]);
dustSurfMedianDayOfYearHATS10=dustSurfMedianDayOfYearHATS10(windowSize+1:end-windowSize);

finalDustTableHATS.DayRankInYear=nan(size(finalDustTableHATS,1),1);
for i=1980:2023;tc=finalDustTableHATS.Year==i;[~,finalDustTableHATS.DayRankInYear(tc)]=sort(finalDustTableHATS.DustSurfMedian(tc),'Descend');end;
HATSDustSurfMedianDayNormed=finalDustTableHATS.DustSurfMedian;
for i=1:366;tc=finalDustTableHATS.DayOfYear==i;HATSDustSurfMedianDayNormed(tc)=HATSDustSurfMedianDayNormed(tc)-dustSurfMedianDayOfYearHATS10(i);end;
HATSDustSurfMedianDayNormedZscore=zscore(HATSDustSurfMedianDayNormed);
corrMonthlyDust=nan(12*(2023-1980+1),1);
for i=1980:2023;for j=1:12;tc=(finalDustTableHATS.Year==i & finalDustTableHATS.Month==j);corrMonthlyDust((i-1980)*12+j,1)=mean(HATSDustSurfMedianDayNormed(tc));end;end;
corrMonthlyDustZ=nan(12*(2023-1980+1),1);
for i=1980:2023;for j=1:12;tc=(j:12:528);corrMonthlyDustZ(tc)=zscore(corrMonthlyDust(tc));end;end;

%make some precipitation mean and normalized variables
windowSize=15;
precipSurfMeanDayOfYearALOHA30=[precipSurfMeanDayOfYearALOHA(end-windowSize+1:end)', precipSurfMeanDayOfYearALOHA', precipSurfMeanDayOfYearALOHA(1:windowSize)']';
precipSurfMeanDayOfYearALOHA30=movmean(precipSurfMeanDayOfYearALOHA30,[windowSize,windowSize]);
precipSurfMeanDayOfYearALOHA30=precipSurfMeanDayOfYearALOHA30(windowSize+1:end-windowSize);

finalPrecipTableHATS.DayRankInYear=nan(size(finalPrecipTableHATS,1),1);
for i=1980:2023;tc=finalPrecipTableHATS.Year==i;[~,finalPrecipTableHATS.DayRankInYear(tc)]=sort(finalPrecipTableHATS.PrecipMeanALOHA(tc),'Descend');end;
ALOHAPrecipMeanDayNormed=finalPrecipTableHATS.PrecipMeanALOHA;
for i=1:366;tc=finalPrecipTableHATS.DayOfYear==i;ALOHAPrecipMeanDayNormed(tc)=ALOHAPrecipMeanDayNormed(tc)-precipSurfMeanDayOfYearALOHA30(i);end;
ALOHAPrecipMeanDayNormedZScore=zscore(ALOHAPrecipMeanDayNormed);
corrMonthlyPrecip=nan(12*(2023-1980+1),1);
for i=1980:2023;for j=1:12;tc=(finalPrecipTableHATS.Year==i & finalDustTableHATS.Month==j);corrMonthlyPrecip((i-1980)*12+j,1)=mean(ALOHAPrecipMeanDayNormed(tc));end;end;
corrMonthlyPrecipZ=nan(12*(2023-1980+1),1);
for i=1980:2023;for j=1:12;tc=(j:12:528);corrMonthlyPrecipZ(tc)=zscore(corrMonthlyPrecip(tc));end;end;

dustDaysRaw=nan(366,44);for i=1980:2023;tc=finalDustTableHATS.Year==i;dustDaysRaw(1:sum(tc),i-1979)=finalDustTableHATS.DustSurfMedian(tc);end;
dustDaysSorted=nan(366,44);for i=1980:2023;tc=finalDustTableHATS.Year==i;[dustDaysSorted(1:sum(tc),i-1979),finalDustTableHATS.DayRankInYear(tc)]=sort(finalDustTableHATS.DustSurfMedian(tc),'Descend');end;
dustDaysSortedNorm=dustDaysSorted./sum(dustDaysSorted,1,'omitnan');
dustDaysSortedNormCumSum=cumsum(dustDaysSortedNorm,1,'omitnan');

%make tempStats10152025 (thresholding tests for cumulative dust)
tempStats10152025=nan(2024-1980,4);
tempPositions=[0.1, 0.15, 0.2, 0.25];
for i=1980:2023;tc=finalDustTableHATS.Year==i;toPlotY=cumsum(finalDustTableHATS.DustSurfMedian(tc))./sum(finalDustTableHATS.DustSurfMedian(tc));for j=1:4;[~,tempStats10152025(i-1979,j)]=min(abs(toPlotY-tempPositions(j)));end;end;

%make variables for correlation analysis of dust pdo and precip
numel=size(finalDustTableHATS,1);
corrDailyPDO=nan(numel,1);for i=1:numel;corrDailyPDO(i)=PDO1980to2023(finalDustTableHATS.Year(i)-1979,finalDustTableHATS.Month(i));end;
corrDailyNino=nan(numel,1);for i=1:numel;corrDailyNino(i)=Nino41980to2023(finalDustTableHATS.Year(i)-1979,finalDustTableHATS.Month(i));end;
corrDailyDust30=movmean(HATSDustSurfMedianDayNormed,[15,15]);
corrDailyDust30Z=movmean(HATSDustSurfMedianDayNormedZscore,[15,15]);
corrDailyPrecip30=movmean(ALOHAPrecipMeanDayNormed,[15,15]);
corrDailyPrecip30Z=movmean(ALOHAPrecipMeanDayNormedZScore,[15,15]);
corrDailyMonthNoVolc=finalDustTableHATS.Month;
corrDailyMonthNoVolc(ismember(finalDustTableHATS.Year,[1992,1993,1982,1983]))=NaN;

clear extendedData i j toPlotY tc tempPositions numel windowSize