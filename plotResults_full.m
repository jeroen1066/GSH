% plot results
clear;
close all;
clc;

%% tutorial data
%%% insert output data file from Results here!!!%%%
%load('Results/data_Crust10_crust_0_179.mat')
load('Results/data_Mars1_0_120.mat')
%% plot different maps of the data
lon = data.grd.lon(1,:);
lats = data.grd.lat(:,1);

<<<<<<< Updated upstream
=======

%resolution = 4;
%filename = 'Data\potential.dat';
%f = fopen(filename,'r','ieee-be');
%pot = fread(f,[360*resolution Inf],'double')';
load('Results/data_Mars_Reference_0_120.mat');

resolution = 4;

prefix = 'Data\meg004\';
filename = [prefix 'megr90n000cb.img'];
%resolution = 4;

% Read in the file.
f = fopen(filename,'r','ieee-be');
el1 = fread(f,[360*resolution Inf],'int16')';

>>>>>>> Stashed changes
figure;
subplot(2,2,3)
imagesc(lon,lats,((ref.pot)));c=colorbar; 
hold on
<<<<<<< Updated upstream
=======
%plot(long,lat,'k','LineWidth',1.5);
>>>>>>> Stashed changes
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Potential gravity field from spherical harmonics')
ylabel(c,'m*m/s/s') 
set(gca,'YDir','normal')

subplot(2,2,4)
imagesc(lon,lats,((data.pot)));c=colorbar; 
hold on
%plot(long,lat,'k','LineWidth',1.5);
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Potential gravity field from bouguer inversion')
ylabel(c,'m*m/s/s') 
set(gca,'YDir','normal')

%error = data.pot- pot;

subplot(2,2,2)
imagesc(lon,lats,((el1)));c=colorbar; 
hold on
%plot(long,lat,'k','LineWidth',1.5);
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Terrain')
ylabel(c,'m*m/s/s') 
set(gca,'YDir','normal')

subplot(2,2,1)
imagesc(lon,lats,((el1)));c=colorbar; 
hold on
%plot(long,lat,'k','LineWidth',1.5);
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Terrain')
ylabel(c,'m*m/s/s') 
set(gca,'YDir','normal')


figure;
subplot(2,2,1)
imagesc(lon,lats,((data.pot)));c=colorbar; 
hold on
%plot(long,lat,'k','LineWidth',1.5);
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Potential gravity field')
ylabel(c,'m*m/s/s') 
set(gca,'YDir','normal')

subplot(2,2,2)
imagesc(lon,lats,((data.vec.Z)).*1e5);c=colorbar; 
hold on
<<<<<<< Updated upstream
=======
%plot(long,lat,'k','LineWidth',1.5);
>>>>>>> Stashed changes
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Z-component of gravity vector')
ylabel(c,'mGal') 
set(gca,'YDir','normal')

subplot(2,2,3)
imagesc(lon,lats,((data.vec.X)).*1e5);c=colorbar; 
hold on
<<<<<<< Updated upstream
=======
%plot(long,lat,'k','LineWidth',1.5);
>>>>>>> Stashed changes
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('X-component of gravity vector (North-South)')
ylabel(c,'mGal') 
set(gca,'YDir','normal')

subplot(2,2,4)
imagesc(lon,lats,((data.vec.Y)).*1e5);c=colorbar; 
hold on
<<<<<<< Updated upstream
=======
%plot(long,lat,'k','LineWidth',1.5);
>>>>>>> Stashed changes
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Y-component of gravity vector (East-West)')
ylabel(c,'mGal') 
set(gca,'YDir','normal')

%% Tensor

figure;
subplot(3,3,1)
imagesc(lon,lats,((data.ten.Tzz).*1e9));c=colorbar;
hold on
<<<<<<< Updated upstream
=======
plot(lon,lats,'k','LineWidth',1.5);
>>>>>>> Stashed changes
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Tzz-component of gravity gradient tensor')
ylabel(c,'Eotvos')
set(gca,'YDir','normal')

subplot(3,3,2)
imagesc(lon,lats,((data.ten.Txz).*1e9));c=colorbar;
hold on
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
<<<<<<< Updated upstream
title(['Txz-component of gravity gradient tensor'])
=======
title('Tzx-component of gravity gradient tensor')
>>>>>>> Stashed changes
ylabel(c,'Eotvos') 
set(gca,'YDir','normal')

subplot(3,3,3)
imagesc(lon,lats,((data.ten.Tyz).*1e9));c=colorbar; 
hold on
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
<<<<<<< Updated upstream
title(['Tyz-component of gravity gradient tensor'])
=======
title('Tzy-component of gravity gradient tensor')
>>>>>>> Stashed changes
ylabel(c,'Eotvos') 
set(gca,'YDir','normal')

subplot(3,3,5)
imagesc(lon,lats,((data.ten.Txx).*1e9));c=colorbar; 
hold on
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Txx-component of gravity gradient tensor')
ylabel(c,'Eotvos') 
set(gca,'YDir','normal')

subplot(3,3,6)
imagesc(lon,lats,((data.ten.Txy).*1e9));c=colorbar;
hold on
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Txy-component of gravity gradient tensor')
ylabel(c,'Eotvos') 
set(gca,'YDir','normal')

subplot(3,3,9)
imagesc(lon,lats,((data.ten.Tyy).*1e9));c=colorbar; 
hold on
xlim([min(lon) max(lon)])
ylim([min(lats) max(lats)])
hold off
xlabel('Longitude [^o]')
ylabel('Latitude [^o]')
title('Tyy-component of gravity gradient tensor')
ylabel(c,'Eotvos') 
set(gca,'YDir','normal')
