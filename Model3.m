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
[V] = Flexture_model_SH_analysis(Model,110e3);
toc

save(['Results/' Model.name '.mat'],'V')

%% Global Spherical Harmonic Synthesis

tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
toc


%% Save data

%DATE = datetime("now");
filename = ['Results/data_' Model.name '_Flexure_' num2str(SHbounds(1)) '_' num2str(SHbounds(2)) '.mat'];
save(filename,'data');

