% Define the directory containing the files
dataDir = "MERRA2-Hawaii_aer"; % Replace with your directory path
filePattern = 'MERRA2_*.SUB.nc'; % Pattern to match your files
fileList = dir(fullfile(dataDir, filePattern));

% Extract filenames
fileNames = {fileList.name};

% Initialize an array to hold parsed dates
fileDates = [];

% Loop through files to extract dates
for i = 1:length(fileNames)
    fileName = fileNames{i};
    % Use regex to extract the date part of the filename
    dateMatch = regexp(fileName, '\.(\d{8})\.SUB\.nc$', 'tokens');
    if ~isempty(dateMatch)
        fileDates(end+1) = str2double(dateMatch{1}{1}); %#ok<*AGROW>
    end
end

% Convert fileDates to datetime format
fileDates = datetime(string(fileDates), 'InputFormat', 'yyyyMMdd');

% Specify the expected date range
startDate = min(fileDates); % Adjust if needed
endDate = max(fileDates);   % Adjust if needed
expectedDates = startDate:endDate;

% Find missing dates
missingDates = setdiff(expectedDates, fileDates);

% Display results
if isempty(missingDates)
    disp('No missing files.');
else
    disp('Missing files:');
    disp(datestr(missingDates));
end

clear fileList fileNames fileDates dateMatch i startDate endDate expectedDates filePattern fileName dataDir missingDates