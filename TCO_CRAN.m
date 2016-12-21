% TCO of C-RAN Architecture for 5G.

% Steps
%   CAPEX
%   OPEX

clear all;
close all;
clc;

%% --- CAPEX --- %%

%% - Equipment Cost 
% Sum of all equipment times the price of each equipment

global TOT_EQcost;

P_RRH = 4472;                          % Price per RRH
N_RRH = 20;                            % Quantity of RRHs
P_BBUpool = 3000;                      % Price per BBU Pool
N_BBUpool = 5;                         % Quantity of BBU Pools
TOT_EQcost = 0;                        % Total equipment cost

EQ_price = [P_RRH P_BBUpool];
EQ_quant = [N_RRH N_BBUpool];


for i = 1:length(EQ_price)
        TOT_EQcost = TOT_EQcost + EQ_quant(i)* EQ_price(i);
end

%% - Infrastructure Cost
% Deployment of fiber infrastructure, cost of leasing fibers and installation of RRH's

global TOT_PTPInfraCost;
global TOT_LeaseFiberCost;
global TOT_InfraCost;

TOT_TrenchDist = 10;                 % Total distance to be trenched
TrenchPrice = 130000;                % Trenching price per Km
FiberLenght = 30;                    % Total lenght of fiber needed
FiberPrice = 160;                    % Price of fiber per KM

TOT_LeaseDist = 0;                   % Total lenght of leased fiber
FiberLease_KM = 200;                 % Leasing price per KM

TOT_PTPInfraCost = TOT_TrenchDist * TrenchPrice + FiberLenght * FiberPrice; %EQ(3.12)

TOT_LeaseFiberCost = TOT_LeaseDist * FiberLease_KM; %EQ(3.20)

TOT_InfraCost = TOT_PTPInfraCost + TOT_LeaseFiberCost; %EQ(3.11)

%% - Installation Cost
% Expenses related to installing the backhaul components in their locations

global TOT_CostInstall;
global TOT_FiberInstCost;
global TOT_MWInstCost;

%fiber
T_InstPort_F= 20;                     % Total time to install a equipament port
N_Port_F= 10;                         % Number of ports to be install
N_Eq_F= 20;                           % Total number of equipment cost 
Pr_Tech_F= 30;                        % Technician salary per hour

for k = 1:length(T_InstPort_F * N_Port_F);
TOT_FiberInstCost= TOT_FiberInstCost + (T_InstPort_F * N_Port_F) * (N_Eq_F * Pr_Tech_F);


end

%microwave
T_InstPort_Mw= 20;                     % Total time to install a equipament port
N_Port_Mw= 10;                         % Number of ports to be install
N_Eq_Mw= 20;                           % Total number of equipment cost 
Pr_Tech_Mw= 30;                        % Technician salary per hour

for k = 1:length(T_InstPort_Mw * N_Port_Mw);
TOT_MWInstCost= TOT_MWInstCost + (T_InstPort_Mw * N_Port_Mw) * (N_Eq_Mw * Pr_Tech_Mw);


end

 TOT_CostInstall= TOT_FiberInstCost + TOT_MWInstCost; %EQ(3.22)


 
 
%% --- OPEX --- %%

%% - Energy Cost
% Yearly energy cost of all active equipment

global Yearly_kW;                   % Yearly kW consumed by equipments
global Price_kW;                    % Price per kW
global TOT_EnergyCost;              % Total energy cost

for i = 1:length(Yearly_kW);
    TOT_EnergyCost = TOT_EnergyCost + (Yearly_kW(i)*Price_kW);
end

%{
%% - Spectrum and Fiber Leasing

global PTP_LeaseCost;               % Yearly fee for maintenance and reparation of rented fiber
global TOT_LeaseCost;               % Total lease cost

PTP_LeaseCost = TOT_LeaseDist * FiberLease_KM;
TOT_LeaseCost = PTP_LeaseCost;

%% - Maintenance Cost
% Regular maintenance routine cost

global RRH_Mcost;                   % RRH maintenance cost
global CO_Mcost;                    % Central Office maintenance cost
global SWlic_cost;                  % Yearly fee for software licenses
global Mon_cost;                    % Yearly salary of the technicians

global TOT_Maint;                 % Total maintenance cost

TOT_Maint = RRH_Mcost + CO_Mcost + SWlic_cost + Mon_cost;

%% - Fault Management
% Expenses related to the reparation of failures in the network

%% - Floor Space
% Yearly rental fee of the floor space
%}

%% --- Plotting --- %%


figure(1);
y = [TOT_EQcost TOT_InfraCost; 200000 150000];
bar(y,0.5,'stacked');
set(gca,'XTickLabel',{'CAPEX', 'OPEX'});
