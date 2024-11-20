tempVarsToCWT={NinoAll,PDOall,corrMonthlyNino,corrMonthlyPDO,...
    HATSDustSurfMedianDayNormed,ALOHAPrecipMeanDayNormed,...
    finalDustTableHATS.DustSurfMedian,finalPrecipTableHATS.PrecipMeanALOHA};
tempVarsNames={'NINO4 (1870-2023)','PDO (1854-2023)','NINO4 (1980-2023)','PDO (1980-2023)',...
    'Dust Anomaly (Whole Domain)','Precip Anomaly (ALOHA)'...
    'Dust (Whole Domain)','Precip (ALOHA)'};
tempVarsFilenames={'NinoAll','PDOAll','Nino1980','PDO1980',...
    'DustAnom','PrecipAnom',...
    'DustRaw','PrecipRaw'};
tempPeriod={years(1/12),years(1/12),years(1/12),years(1/12),...
    years(1/365.25),years(1/365.25),...
    years(1/365.25),years(1/365.25)};
tempXLabels={'Time (years; 0=1870)','Time (years; 0=1854)','Time (years; 0=1980)','Time (years; 0=1980)',...
    'Time (years; 0=1980)','Time (years; 0=1980)',...
    'Time (years; 0=1980)','Time (years; 0=1980)'};

hFig=figure('position',[-1230, 408, 643, 420]);
hLines=[1,0.5,1/12];
hLinesHandles=nan(3,1);
hLinesStyles={'k:','k:','k:'};
clims=[0,0,0,0,...
    .04e-8,.09e-4,...
    .08e-8,.15e-4];
ylims={[],[],[],[],...
    [1/24 13],[1/24 13],...
    [1/24 13],[1/24 13]};

for i=1:size(tempVarsToCWT,2)
    cwt(tempVarsToCWT{i},'morse',tempPeriod{i});
    title(gca,sprintf('%s Wavelet Analysis',tempVarsNames{i}));
    xlabel(tempXLabels{i});
    if ~isempty(ylims{i})
        ylim(ylims{i});
    end
    for j=1:size(hLines,2)
        hLinesHandles(j)=hline(hLines(j),hLinesStyles{j});
    end
    set(hLinesHandles,'linewidth',1.5);
    if clims(i)>0
        clim([0 clims(i)]);
    end
    pause;
    saveas(hFig,sprintf('./Figures/%s_wavelet.png',tempVarsFilenames{i}));
    saveas(hFig,sprintf('./Figures/%s_wavelet.fig',tempVarsFilenames{i}));
    if i~=size(tempVarsToCWT,2)
        clf;
    end
end
f
clear tempVarsToCWT tempVarsNames tempVarsFilenames tempXLabels tempPeriod hFig hLines i j clims ylims hLinesHandles hLinesStyles
