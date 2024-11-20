directoryPath = 'MERRA2-Hawaii_aer/';
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
    fDustSurf=double(h5read(fName,'/DUSMASS'));
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
    tempTable=table(fYear,fMonth,fDay,{fDustSurf},...
        VariableNames={'Year','Month','Day','DustSurf'});
    
    if i==1
        finalDustTable=tempTable;
    else
        finalDustTable(i,:)=tempTable;
    end
    
    if toc - lastUpdate >= 5 || i==1
        fprintf(repmat('\b', 1, lastLength));
        tempMsg=sprintf('Iteration %d of %d.', i, totalIterations);
        fprintf(tempMsg);
        lastLength=length(tempMsg);
        lastUpdate = toc;
    end

end
fprintf('\nCalculating daily medians.');

numel=size(finalDustTable,1);
finalDustTable.Date=NaT(numel,1);
finalDustTable.DayOfYear=nan(numel,1);

finalDustTable.DustSurfMedian=nan(numel,1);
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
    finalDustTable.Date(i)=datetime(finalDustTable.Year(i),finalDustTable.Month(i),finalDustTable.Day(i),0,0,0);
    finalDustTable.DayOfYear(i)=day(finalDustTable.Date(i),'dayofyear');
    
    finalDustTable.DustSurfMedian(i)=median(finalDustTable.DustSurf{i}(:));
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

dustSurfMedianDayOfYearHATS=nan(366,1);
%dustSurfMedianDayOfYearHATS_ALOHA=nan(366,1);
%bcSurfMedianDayOfYearHATS=nan(366,1);
%so2SurfMedianDayOfYearHATS=nan(366,1);
%so4SurfMedianDayOfYearHATS=nan(366,1);
%ocSurfMedianDayOfYearHATS=nan(366,1);

for i=1:366
    tc=finalDustTable.DayOfYear==i;
    dustSurfMedianDayOfYearHATS(i)=median(finalDustTable.DustSurfMedian(tc),'omitnan');
    %dustSurfMedianDayOfYearHATS_ALOHA(i)=median(finalDustTable.DustSurfMedian_ALOHA(tc),'omitnan');
    %bcSurfMedianDayOfYearHATS(i)=median(finalDustTable.BCSurfMedian(tc),'omitnan');
    %so2SurfMedianDayOfYearHATS(i)=median(finalDustTable.SO2SurfMedian(tc),'omitnan');
    %so4SurfMedianDayOfYearHATS(i)=median(finalDustTable.SO4SurfMedian(tc),'omitnan');
    %ocSurfMedianDayOfYearHATS(i)=median(finalDustTable.OCSurfMedian(tc),'omitnan');

end

DustLatHATS=fLat;
DustLonHATS=fLon;
finalDustTableHATS=sortrows(finalDustTable,["Year" "Month" "Day"]);
finalDustTableHATS = removevars(finalDustTableHATS, "DustSurf");

clear i tc yearPatterns filesStruct filterMask directoryPath startYear endYear numel lastLength tempMsg fName fYear fMonth fLon fLat fDustMass fDustMass25 fDustSurf fDustSurf25 tempTable fList totalIterations lastUpdate fDay 
fprintf('\nDone.\n');