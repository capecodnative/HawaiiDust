%Write Table 1A Data
tempData=nan(2,1);
tempDays=nan(2,1);
[tempData(1), tempDays(1)] = max(dustSurfMedianDayOfYearHATS(1:365));
[tempData(2), tempDays(2)] = min(dustSurfMedianDayOfYearHATS(1:365));
writetable(table(tempData,tempDays,'VariableNames',{'Dust at MinOrMax','DayOfYear'}),'./Tables/Table1A_MaxMinMedianDust_ug_m3.csv');

%Write Table 1B Data
tempPercentiles=[0,1,5,25,50,75,95,99,100];
tempData=prctile(finalDustTableHATS.DustSurfMedian,tempPercentiles)*10^9;
writetable(table(tempPercentiles',tempData','VariableNames',{'Percentile','Dust in ug per m3'}),'./Tables/Table1B_PercentilesDustAllData_ug_m3.csv');

%Write Table 1C Data
tempPercentiles=[0,1,5,25,75,95,99,100];
tempData=prctile(finalDustTableHATS.DustSurfMedian,tempPercentiles);
tempKeyRatios=[tempData(end)./tempData(1);...
    tempData(end-1)./tempData(2);...
    tempData(end-2)./tempData(3);...
    tempData(end-3)./tempData(4)];
writetable(table(tempKeyRatios),'./Tables/Table1C_KeyPercentileRatios.csv');

%Write Table S1 Data
sumAllDust=sumSpringDust+sumFallDust;
[~, ranks]=sort(sumAllDust,'descend');[~, rankedAllDust]=sort(ranks);
[~, ranks]=sort(sumSpringDust,'descend');[~, rankedSpringDust]=sort(ranks);
[~, ranks]=sort(sumFallDust,'descend');[~, rankedFallDust]=sort(ranks);
thresholdsTable=table((1980:2023)',sumAllDust,rankedAllDust,sumSpringDust,rankedSpringDust,sumFallDust,rankedFallDust,tempStats10152025,'VariableNames',{'Year','Annual Dust','Rank AnnualDust','Spring Dust','Rank SpringDust','Fall Dust','Rank FallDust','Thresholds'});
writetable(thresholdsTable,'./Tables/TableS1.csv')

%Write Table 2 Data
tempTable2=nan(4,3);
tempTable2(1,1)=mean(sumSpringDust+sumFallDust);
tempTable2(1,2)=mean(sumSpringDust);
tempTable2(1,3)=mean(sumFallDust);
tempTable2(2,1)=std(sumSpringDust+sumFallDust);
tempTable2(2,2)=std(sumSpringDust);
tempTable2(2,3)=std(sumFallDust);
tempTable2(3,1)=tempTable2(2,1)/tempTable2(1,1);
tempTable2(3,2)=tempTable2(2,2)/tempTable2(1,2);
tempTable2(3,3)=tempTable2(2,3)/tempTable2(1,3);
tempTable2(4,1)=1;
tempTable2(4,2)=tempTable2(1,2)/tempTable2(1,1);
tempTable2(4,3)=tempTable2(1,3)/tempTable2(1,1);
writetable(table(tempTable2(:,1),tempTable2(:,2),tempTable2(:,3),'VariableNames',{'Annual','Spring','Fall'},'RowNames',{'CumDust','CumDustStdev','RSD','PrctInPeriod'}),'./Tables/Table2.csv');

%Write Table 3 Data
tempTable3=nan(2,4);
tempTable3(1,:)=mean(tempStats10152025);
tempTable3(2,:)=std(tempStats10152025);
writetable(table(tempTable3(:,1),tempTable3(:,2),tempTable3(:,3),tempTable3(:,4),'VariableNames',{'10th Pctile','15th Pctile','20th Pctile','25th Pctile'},'RowNames',{'Mean Day Crossed','Stdev of DayCrossed'}),'./Tables/Table3.csv');

clear tempPercentiles tempData tempDays tempTable2 tempTable3 tempKeyRatios ranks rankedAllDust rankedSpringDust rankedFallDust thresholdsTable