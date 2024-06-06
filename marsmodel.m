% Single values for density files are allowed.
HOME = pwd;
Model = struct();

Model.number_of_layers = 2;
Model.name = 'Mars1';

% Additional variables
Model.GM = 4.2828372854187757E13;
Model.Re_analyse = 3396000;
Model.Re = 3396000;
Model.geoid = 'none';
Model.nmax = 120;     
Model.correct_depth = 0;

% % Topo layer
Model.l1.bound = [HOME '/Data/mars1.bd1.txt'];
Model.l1.dens  = [HOME '/Data/mars1.rho1.txt'];
% %Model.l1.alpha = 

% Bath layer
Model.l2.bound = [HOME '/Data/mars1.bd2.txt'];
Model.l2.dens  = [HOME '/Data/mars1.rho2.txt'];
% %Model.l2.alpha = 
% 
% % Sediment layer
Model.l3.bound = [HOME '/Data/mars1.bd3.txt'];
%Model.l3.dens  = [HOME '/Data/mars1.rho3.mat'];


%Model.l4.bound = [HOME "/Data/mars1.bd4.mat"];



save([HOME '/Data/' Model.name '.mat'],'Model')