% Assuming fLat and fLon are the latitudes and longitudes of the MERRA-2 product grid
% Example grid (for demonstration, replace these with actual MERRA-2 grid variables)
%fLat = 15:0.5:28; % Latitude grid points
%fLon = -165:0.625:-150; % Longitude grid points
fLat=DustLatHATS;
fLon=DustLonHATS;

figure;

% Define the region of interest for Hawaii and the surrounding ocean
latLimits = [min(fLat)-.5/2, max(fLat)+.5/2]; % Latitude limits from 15ºN to 28ºN
lonLimits = [min(fLon)-.625/2, max(fLon)+.625/2]; % Longitude limits from 165ºW to 150ºW (note the sign for west)

% Latitude and Longitude for Ocean Station ALOHA
aloha_lat = 22.75;
aloha_lon = -158;

% Generate a map of the specified region
worldmap(latLimits, lonLimits);
geoshow('landareas.shp', 'FaceColor', [0.5 0.7 0.5]); % Show land areas

% Overlay the MERRA-2 grid on the map
% Convert grid points to a meshgrid for plotting
[lonMesh, latMesh] = meshgrid(fLon, fLat);

% Plot the grid
tempGrid = plotm(latMesh, lonMesh, 'r.');

tLat = [fLat(14)-0.25 fLat(18)+0.25];
tLon = [fLon(10)-.625/2 fLon(14)+.625/2];
latCorners = [tLat(1), tLat(1), tLat(2), tLat(2), tLat(1)];
lonCorners = [tLon(1), tLon(2), tLon(2), tLon(1), tLon(1)];

geoshow(latCorners, lonCorners, 'DisplayType', 'line', 'Color', 'b', 'LineWidth', 2);
hold on;

% Plotting Ocean Station ALOHA with a star marker
plotm(aloha_lat, aloha_lon, 'p', 'MarkerSize', 15, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');

% Adding a circle to represent the 6-mile radius
tempCircle = scircle1(aloha_lat, aloha_lon, 6, [], wgs84Ellipsoid("mile"));
plotm(tempCircle(:,1), tempCircle(:,2), 'w');


title({'Study Region with MERRA-2 Grid Overlay,';'Hawaii, and Surrounding N. Pacific Ocean'});
uistack(tempGrid,'top');
set(get(gca,'Title'),'fontsize',20)
set(findobj('type','line'),'linewidth',1.5)
set(findobj('type','text'),'fontsize',15)
saveas(gcf,'./Figures/Figure1_map.fig');
saveas(gcf,'./Figures/Figure1_map.png');

clear aloha_lon aloha_lat fLat fLon latCorners latLimits lonCorners lonLimits lonMesh latMesh tempCircle tempGrid tLat tLon
