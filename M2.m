clear;
clc;
close all
set(gca,'fontsize', 16)
HOME = pwd;
addpath([HOME '/Data']);
addpath([HOME '/Tools']);

% Import data
V = importdata('Data/shadr/jgmro_120f_sha.tab');
header = V(1,:);
V = [0 0 1 0; V(2:end,1:4)];
% If we only want perturbations
V(1,3) = 0;
V(4,3)=0;
V = sortrows(V,2);

% Define latitude and longitude limits
latLim = [-89.5 89.5 1];  % [deg] min latitude, max latitude, resolution latitude
lonLim = [-180 180 1];    % [deg] min longitude, max longitude, resolution longitude
height = 225000.0;        % Height of computation above spheroid
SHbounds = [0 120];       % Truncation settings: lower limit, upper limit SH-coefficients used

% Model parameters
Model = struct();
Model.GM = 4.282837E13;
Model.Re = header(1)*1000;

% Spherical Harmonic synthesis to obtain gravitational potential
%[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);

% Read in the topography file
filename = 'Data/meg004/megt90n000cb.img';
resolution = 4;
f = fopen(filename,'r','ieee-be');
Topo = fread(f,[360*resolution Inf],'int16')';
fclose(f);

% Generate latitude and longitude matrices
a = -90:1/resolution:89.75;
b = 0:1/resolution:359.75;
lat = ones(size(Topo)).*a';
lon = b.*ones(size(Topo));

% Define density and reference thickness values
density_crust = 2900;  % kg/m^3
density_mantle = 3400; % kg/m^3 
reference_thickness = 50000; % meters (change value)

% Convert Topo to height above reference
h = Topo; % Assuming Topo is already in meters

% Gravitational constant
G = 6.67430e-11; % m^3 kg^-1 s^-2

% Bouguer correction
bouguer_correction = 2 * pi * G * density_crust * h;

% Apply Bouguer correction to the gravitational potential data
% data_corrected = data - bouguer_correction;

% Calculate isostatic root (r)
r = (h * density_crust) / (density_mantle - density_crust);

% Calculate total crustal thickness (T_crust)
T_crust = (h + reference_thickness + r) / 1000;

disp(mean(flip(T_crust(:))));
disp(min(flip(T_crust(:))));
disp(max(flip(T_crust(:))));

flipped_T_crust = flip(T_crust);
writematrix(flipped_T_crust, 'Results\airy_crustal_thickness.txt');

% Limit the ranges for elevation and crustal thickness
elevation_min = -5; % km
elevation_max = 5; % km
thickness_min = 5; % km
thickness_max = 100; % km

% Clip the data within the specified ranges
Topo(Topo < elevation_min * 1000) = elevation_min * 1000;
Topo(Topo > elevation_max * 1000) = elevation_max * 1000;

T_crust(T_crust < thickness_min) = thickness_min;
T_crust(T_crust > thickness_max) = thickness_max;

% Plot the original topography
figure
contourf(lon, lat, flip(Topo / 1000), 30, 'LineStyle', 'none')
colormap(parula)
caxis([elevation_min elevation_max])
cb = colorbar;
cb.Label.String = 'Elevation [km]';
set(cb, 'FontSize', 14);
xlabel('Longitude [°]', 'FontSize', 14)
ylabel('Latitude [°]', 'FontSize', 14)
set(gca, 'FontSize', 14)
axis equal
title('Topography', 'FontSize', 14)
ax = gca;
exportgraphics(ax,'Results\figs\topo.png','Resolution',300)

% Plot the isostatic topography
figure
contourf(lon, lat, flip(T_crust), 30, 'LineStyle', 'none')
colormap(parula)
caxis([thickness_min thickness_max])
cb = colorbar;
cb.Label.String = 'Crustal Thickness [km]';
set(cb, 'FontSize', 14);
xlabel('Longitude [°]', 'FontSize', 14)
ylabel('Latitude [°]', 'FontSize', 14)
set(gca, 'FontSize', 14)
axis equal
title('Airy Isostasy Model', 'FontSize', 14)
ax = gca;
exportgraphics(ax,'Results\figs\airy.png','Resolution',300)

figure; % Open a new figure window
histogram(flip(T_crust), 50, 'Normalization', 'probability', 'FaceColor', '#0072BD'); % Create the histogram with normalization
xlabel('Crustal thickness [km]', 'FontSize', 16); % Label the x-axis
ylabel('Area [%]', 'FontSize', 16); % Label the y-axis
% Calculate the mean value of T_crust
mean_value = mean(flip(T_crust(:)));
% Plot a vertical line at the mean value
disp(mean_value)
xline(mean_value, 'Color', '#EDB120', 'LineWidth', 2);
% Adjust y-axis tick labels to percentage
yt = get(gca, 'YTick'); % Get current y-tick values
yt_percentage = yt * 100; % Convert to percentage
set(gca, 'YTickLabel', yt_percentage); % Set the y-tick labels

% Plot the isostatic root (r)
figure
surf(lon, lat, flip(r)/1000, 'EdgeColor', 'none')
colormap default
colorbar
caxis([-elevation_max elevation_max])
cb = colorbar;
cb.Label.String = 'Isostatic Root [km]';
set(cb, 'FontSize', 14);
xlabel('Longitude [°]', 'FontSize', 14)
ylabel('Latitude [°]', 'FontSize', 14)
zlabel('Isostatic Root [km]', 'FontSize', 14)
set(gca, 'FontSize', 14)
axis equal
ax = gca;
exportgraphics(ax,'Results\figs\isostatic_root.png','Resolution',300)

% Save the results
save('Results/data_Mars_m2.mat','data','T_crust')
