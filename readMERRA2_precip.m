directoryPath = 'MERRA2-Hawaii_flx/';
startYear = 1980;
endYear = 2023;

yearPatterns = arrayfun(@(year) sprintf('Nx.%d', year), startYear:endYear, 'UniformOutput', false);
filesStruct = dir(fullfile(directoryPath, '*.nc'));
filterMask = arrayfun(@(file) any(cellfun(@(pattern) contains(file.name, pattern), yearPatterns)), filesStruct);
fList = filesStruct(filterMask);

tic;
lastUpdate=toc;
totalIterations=size(fList,1);
fprintf('\nStarting...\n');
lastLength=0;

for i=1:totalIterations
    fName=strcat(fList(i).folder,"/",fList(i).name);
    fYear=str2double(cell2mat(extractBetween(fList(i).name,28,31)));
    fMonth=str2double(cell2mat(extractBetween(fList(i).name,32,33)));
    fDay=str2double(cell2mat(extractBetween(fList(i).name,34,35)));
    if i==1
    fLat=double(ncread(fName,'lat'));
    fLon=double(ncread(fName,'lon'));
    end
    fPrecipTotCorr=double(h5read(fName,'/PRECTOTCORR'));
    %fDustSurf25=double(h5read(fName,'/DUSMASS25'));
    %fDustMass=double(h5read(fName,'/DUCMASS'));
    %fDustMass25=double(h5read(fName,'/DUCMASS25'));
    %fBCMass=double(h5read(fName,'/BCCMASS'));
    %fBCSurf=double(h5read(fName,'/BCSMASS'));
    %fSO2Mass=double(h5read(fName,'/SO2CMASS'));
    %fSO2Surf=double(h5read(fName,'/SO2SMASS'));
    %fSO4Mass=double(h5read(fName,'/SO4CMASS'));
    %fSO4Surf=double(h5read(fName,'/SO4SMASS'));
    %fOCMass=double(h5read(fName,'/OCCMASS'));
    %fOCSurf=double(h5read(fName,'/OCSMASS'));
    %tempTable=table(fYear,fMonth,fDay,{fDustSurf},{fDustSurf25},{fDustMass},{fDustMass25},{fBCMass},{fBCSurf},...
    %    {fSO2Mass},{fSO2Surf},{fSO4Mass},{fSO4Surf},{fOCMass},{fOCSurf},...
    %    VariableNames={'Year','Month','Day','DustSurf','DustSurf25','DustMass','DustMass25','BCMass','BCSurf',...
    %    'SO2Mass','SO2Surf','SO4Mass','SO4Surf','OCMass','OCSurf'});
    tempTable=table(fYear,fMonth,fDay,{fPrecipTotCorr},...
        VariableNames={'Year','Month','Day','Precip'});
    
    if i==1
        finalPrecipTable=tempTable;
    else
        finalPrecipTable(i,:)=tempTable;
    end
    
    if toc - lastUpdate >= 5 || i==1
        fprintf(repmat('\b', 1, lastLength));
        tempMsg=sprintf('Iteration %d of %d.', i, totalIterations);
        fprintf(tempMsg);
        lastLength=length(tempMsg);
        lastUpdate = toc;
    end

end
fprintf('\nCalculating daily medians and means.\n');

numel=size(finalPrecipTable,1);
finalPrecipTable.Date=NaT(numel,1);
finalPrecipTable.DayOfYear=nan(numel,1);

%finalPrecipTable.PrecipMedian=nan(numel,1);
%finalPrecipTable.PrecipMean=nan(numel,1);
%finalPrecipTable.PrecipMedianALOHA=nan(numel,1);
finalPrecipTable.PrecipMeanALOHA=nan(numel,1);
%finalDustTable.DustSurf25Median=nan(numel,1);
%finalDustTable.DustMassMedian=nan(numel,1);
%finalDustTable.DustMass25Median=nan(numel,1);

%finalDustTable.DustSurfMedian_ALOHA=nan(numel,1);
%finalDustTable.DustSurf25Median_ALOHA=nan(numel,1);
%finalDustTable.DustMassMedian_ALOHA=nan(numel,1);
%finalDustTable.DustMass25Media_ALOHA=nan(numel,1);

%finalDustTable.BCMassMedian=nan(numel,1);
%finalDustTable.BCSurfMedian=nan(numel,1);
%finalDustTable.SO2MassMedian=nan(numel,1);
%finalDustTable.SO2SurfMedian=nan(numel,1);
%finalDustTable.SO4MassMedian=nan(numel,1);
%finalDustTable.SO4SurfMedian=nan(numel,1);
%finalDustTable.OCMassMedian=nan(numel,1);
%finalDustTable.OCSurfMedian=nan(numel,1);

for i=1:numel
    finalPrecipTable.Date(i)=datetime(finalPrecipTable.Year(i),finalPrecipTable.Month(i),finalPrecipTable.Day(i),0,0,0);
    finalPrecipTable.DayOfYear(i)=day(finalPrecipTable.Date(i),'dayofyear');
    
    %finalPrecipTable.PrecipMedian(i)=median(finalPrecipTable.Precip{i}(:),'all','omitnan');
    %finalPrecipTable.PrecipMean(i)=mean(finalPrecipTable.Precip{i}(:),'all','omitnan');
    %finalPrecipTable.PrecipMedianALOHA(i)=median(finalPrecipTable.Precip{i}(10:14,14:18,:),'all','omitnan');
    finalPrecipTable.PrecipMeanALOHA(i)=mean(finalPrecipTable.Precip{i}(10:14,14:18,:),'all','omitnan');
    
    %finalPrecipTable.PrecipMedian(i)=median(finalPrecipTable.Precip{i}(:));
    %finalPrecipTable.PrecipMean(i)=mean(finalPrecipTable.Precip{i}(:));
    %finalDustTable.DustSurf25Median(i)=median(finalDustTable.DustSurf25{i}(:));
    %finalDustTable.DustMassMedian(i)=median(finalDustTable.DustMass{i}(:));
    %finalDustTable.DustMass25Median(i)=median(finalDustTable.DustMass25{i}(:));

    %finalDustTable.DustSurfMedian_ALOHA(i)=median(reshape(finalDustTable.DustSurf{i}(10:14,13:17,:),[],1));
    %finalDustTable.DustSurf25Median_ALOHA(i)=median(reshape(finalDustTable.DustSurf25{i}(10:14,13:17,:),[],1));
    %finalDustTable.DustMassMedian_ALOHA(i)=median(reshape(finalDustTable.DustMass{i}(10:14,13:17,:),[],1));
    %finalDustTable.DustMass25Media_ALOHA(i)=median(reshape(finalDustTable.DustMass25{i}(10:14,13:17,:),[],1));

    %finalDustTable.BCMassMedian(i)=median(finalDustTable.BCMass{i}(:));
    %finalDustTable.BCSurfMedian(i)=median(finalDustTable.BCSurf{i}(:));
    %finalDustTable.SO2MassMedian(i)=median(finalDustTable.SO2Mass{i}(:));
    %finalDustTable.SO2SurfMedian(i)=median(finalDustTable.SO2Surf{i}(:));
    %finalDustTable.SO4MassMedian(i)=median(finalDustTable.SO4Mass{i}(:));
    %finalDustTable.SO4SurfMedian(i)=median(finalDustTable.SO4Surf{i}(:));
    %finalDustTable.OCMassMedian(i)=median(finalDustTable.OCMass{i}(:));
    %finalDustTable.OCSurfMedian(i)=median(finalDustTable.OCSurf{i}(:));

    if toc - lastUpdate >= 5 || i==1
        fprintf(repmat('\b', 1, lastLength));
        tempMsg=sprintf('Iteration %d of %d.', i, totalIterations);
        fprintf(tempMsg);
        lastLength=length(tempMsg);
        lastUpdate = toc;
    end
end

fprintf('\nCalculating day-of-year medians.\n');

%precipSurfMedianDayOfYearHATS=nan(366,1);
%precipSurfMeanDayOfYearHATS=nan(366,1);
%precipSurfMedianDayOfYearALOHA=nan(366,1);
precipSurfMeanDayOfYearALOHA=nan(366,1);
%dustSurfMedianDayOfYearHATS_ALOHA=nan(366,1);
%bcSurfMedianDayOfYearHATS=nan(366,1);
%so2SurfMedianDayOfYearHATS=nan(366,1);
%so4SurfMedianDayOfYearHATS=nan(366,1);
%ocSurfMedianDayOfYearHATS=nan(366,1);

for i=1:366
    tc=finalPrecipTable.DayOfYear==i;
    %precipSurfMedianDayOfYearHATS(i)=median(finalPrecipTable.PrecipMedian(tc),'omitnan');
    %precipSurfMeanDayOfYearHATS(i)=mean(finalPrecipTable.PrecipMean(tc),'omitnan');
    %precipSurfMedianDayOfYearALOHA(i)=median(finalPrecipTable.PrecipMedianALOHA(tc),'omitnan');
    precipSurfMeanDayOfYearALOHA(i)=mean(finalPrecipTable.PrecipMeanALOHA(tc),'omitnan');
    %dustSurfMedianDayOfYearHATS_ALOHA(i)=median(finalDustTable.DustSurfMedian_ALOHA(tc),'omitnan');
    %bcSurfMedianDayOfYearHATS(i)=median(finalDustTable.BCSurfMedian(tc),'omitnan');
    %so2SurfMedianDayOfYearHATS(i)=median(finalDustTable.SO2SurfMedian(tc),'omitnan');
    %so4SurfMedianDayOfYearHATS(i)=median(finalDustTable.SO4SurfMedian(tc),'omitnan');
    %ocSurfMedianDayOfYearHATS(i)=median(finalDustTable.OCSurfMedian(tc),'omitnan');

end

%PrecipLatHATS=fLat;
%PrecipLonHATS=fLon;
PrecipLatALOHA=fLat(14:18);
PrecipLonALOHA=fLon(10:14);
finalPrecipTableHATS=sortrows(finalPrecipTable,["Year" "Month" "Day"]);
finalPrecipTableHATS = removevars(finalPrecipTableHATS, "Precip");

clear i tc yearPatterns filesStruct filterMask directoryPath startYear endYear numel lastLength tempMsg fName fYear fMonth fLon fLat fDustMass fDustMass25 fPrecipTotCorr fDustSurf25 tempTable fList totalIterations lastUpdate fDay 
fprintf('\nDone.\n');