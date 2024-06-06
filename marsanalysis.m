% makefile for the complete GSH circle for a particular model
clear;
close all;
clc;

HOME = pwd;
addpath([HOME '/Data']);
addpath([HOME '/Tools']);

% Model
% Load previous saved model

%model_name = 'Crust01_crust';
%load(model_name);

% Construct new model
marsmodel    

%%%%%%%%%%%%%%%%%%% Computation area %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

latLim =    [-90+0.125    90-0.125 0.25];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [-180+0.125 180-0.125 0.25];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0.0; % height of computation above spheroid
SHbounds =  [0 120]; % Truncation settings: lower limit, upper limit SH-coefficients used

%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

%% Global Spherical Harmonic Analysis 

tic;
[V] = model_SH_analysis(Model);
toc

save(['Results/' Model.name '.mat'],'V')

%% Global Spherical Harmonic Synthesis

tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
toc

%% Reference Spherical Harmonic Synthesis

sphericalharmonics = importdata("Data\shadr\gmm3_120_sha.tab");
sphericalharmonics(1,:) = [0,0,1,0,0,0,0,0];
sphericalharmonics(:,5:8) = [];



tic;
[ref] = model_SH_synthesis(lonLim,latLim,height,SHbounds,sphericalharmonics,Model);
toc

%% Save data

%DATE = datetime("now");
filename = ['Results/data_' Model.name '_' num2str(SHbounds(1)) '_' num2str(SHbounds(2)) '.mat'];
save(filename,'data');

filename = ['Results/data_' 'Mars_Reference' '_' num2str(SHbounds(1)) '_' num2str(SHbounds(2)) '.mat'];
save(filename,'ref')