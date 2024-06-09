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

sphericalharmonics = importdata("Data\shadr\gmm3_120_sha.tab");
sphericalharmonics(1,:) = [0,0,1,0,0,0,0,0];
sphericalharmonics(:,5:8) = [];

sphericalharmonics_ordered = sortrows(sphericalharmonics,2);

% Construct new model
marsmodel_airy 

%%%%%%%%%%%%%%%%%%% Computation area %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

latLim =    [-90+0.125    90-0.125 0.25];  % [deg] min latitude, max latitude, resolution latitude (preferable similar to latitude)
lonLim =    [-180+0.125 180-0.125 0.25];% [deg] min longitude, max longitude, resolution longitude (preferable similar to latitude)
height =    0.0; % height of computation above spheroid
SHbounds =  [0 120]; % Truncation settings: lower limit, upper limit SH-coefficients used

%%%%%%%%%%%%%% Part that can be modified %%%%%%%%%%%%%%%%%%%%%%%

%% Global Spherical Harmonic Analysis 

tic;
[V] = Flexture_model_SH_analysis(Model,160e3);
toc

save(['Results/' Model.name '.mat'],'V')

%% Global Spherical Harmonic Synthesis

tic;
[data] = model_SH_synthesis(lonLim,latLim,height,SHbounds,V,Model);
toc

%%

variance_model = zeros(121);
variance_accurate = zeros(121);
for i = 1:7381
    j = 0;
    order = V(i,1);
    variance_model(order+1) = variance_model(order+1) + V(i,3)^2+V(i,4)^2 ;
    variance_accurate(order+1) = variance_accurate(order+1) + sphericalharmonics_ordered(i,3)^2 + sphericalharmonics_ordered(i,4)^2;
end

orders = 0:120;


plot(orders,variance_model)
xlabel('order')
ylabel('Variance')
yscale log

title('Spectral variance of the M3 model compared to the reference')
hold("on")
plot(orders,variance_accurate)
fontsize(10,"points")

hold("off")
legend('Model','Reference')

%% Save data

%DATE = datetime("now");
filename = ['Results/data_' Model.name '_Flexure_' num2str(SHbounds(1)) '_' num2str(SHbounds(2)) '.mat'];
save(filename,'data');

