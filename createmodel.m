% makefile for the complete GSH circle for a particular model
clear;
close all;
clc;
%% This file creates spherically symmetric layers with a resolution of 4 points per degree

resolution = 4;

prefix = 'Data\meg004\';
filename = [prefix 'megr90n000cb.img'];
%resolution = 4;

% Read in the file.
f = fopen(filename,'r','ieee-be');
el1 = fread(f,[360*resolution Inf],'int16')';

dpp = 1/resolution;
numlat = resolution * 180;
numlong = resolution * 360;
longitude = linspace(-90+dpp/2,90-dpp/2,numlat);
lattitude = linspace(dpp/2,360-dpp/2,numlong);

edge0 = 0;
edge1 = -50;%km
edge2 = -1400;%km

density1 = 2.900;%ton/m3
density2 = 3.500;%ton/m3

edgematrix1 = zeros(numlat*numlong,3);
edgematrix2 = zeros(numlat*numlong,3);
edgematrix3 = zeros(numlat*numlong,3);
densitymatrix1 = zeros(numlat*numlong,3);
densitymatrix2 = zeros(numlat*numlong,3);

for i = 1:numlat
    for j = 1:numlong
        edgematrix1((i-1)*numlong+j,1)=lattitude(j);
        edgematrix1((i-1)*numlong+j,2)=longitude(i);
        edgematrix2((i-1)*numlong+j,1)=lattitude(j);
        edgematrix2((i-1)*numlong+j,2)=longitude(i);
        edgematrix3((i-1)*numlong+j,1)=lattitude(j);
        edgematrix3((i-1)*numlong+j,2)=longitude(i);
        densitymatrix1((i-1)*numlong+j,1)=lattitude(j);
        densitymatrix1((i-1)*numlong+j,2)=longitude(i);
        densitymatrix2((i-1)*numlong+j,1)=lattitude(j);
        densitymatrix2((i-1)*numlong+j,2)=longitude(i);
        edgematrix1((i-1)*numlong+j,3)=el1(i,j)/1000;
    end
end

%edgematrix1(:,3) = 0;
edgematrix2(:,3) = edge1;
edgematrix3(:,3) = edge2;
densitymatrix1(:,3) = density1;
densitymatrix2(:,3) = density2;

filename = ['Data/mars1.bd1.txt'];
writematrix(edgematrix1,filename,'Delimiter','tab');
filename = ['Data/mars1.bd2.txt'];
writematrix(edgematrix2,filename,'Delimiter','tab');
filename = ['Data/mars1.bd3.txt'];
writematrix(edgematrix3,filename,'Delimiter','tab');

filename = ['Data/mars1.rho1.txt'];
writematrix(densitymatrix1,filename,'Delimiter','tab');
filename = ['Data/mars1.rho2.txt'];
writematrix(densitymatrix2,filename,'Delimiter','tab');