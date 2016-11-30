% TCO of C-RAN Architecture for 5G

% Steps
%   Traffic Demand
%   CAPEX
%   OPEX

clear all;
close all;
clc;

%% --- TRAFFIC DEMAND --- %%

Area = 100                                    % Area in Km^2
Population = 300000;                          % Total population of the area
Sub_Fraction = 0.16;                          % Fraction of subscribers
global User_Density;                          % Subscriber Density in the area
global Mob_Sub;                               % Number of Mobile Subscribers
N_oper = 1;                                   % Number of Mobile Operators
Peak_TD = 0.16;                               % Traffic Demand at peak hours [16%]

DR_total = 0   ;                              % Data rate per user * Number of users
global Daily_Traffic;                         % Daily generated traffic [Mbps/km^2]

Mob_Sub = Population * Sub_Fraction;
User_Density = Mob_Sub / Area;
%{
H_userP;                                      % Heavy user Fraction
O_userP = 100 - H_userP;                      % Ordinary user Fraction

Hourly_DR_H = [HDR_H_pc HDR_H_tab HDR_H_pho]; % Hourly DR for heavy users
Hourly_DR_O = [HDR_O_pc HDR_O_tab HDR_O_pho]; % Hourly DR for ordin users 

Data_rate = [DR_pc DR_tab DR_pho];            % Average data rate 
Subscribers = [Sub_pc Sub_tab Sub_pho];       % Fraction of subscribers 

for i = 1:3                             
    Data_rate(i) = (H_userP * Hourly_DR_H(i) + O_userP * Hourly_DR_O(i))/45000;
    DR_total = DR_total + (Data_rate(i) * Subscribers(i));
end


Daily_Traffic = (User_Density * Peak_TD * DR_total) / N_oper;
%}
%% --- CAPEX --- %%

%% - Equipment Cost
% Sum of all equipment times the price of each equipment

global TOT_EQcost;

P_RRH = 4472;                          % Price per RRH
N_RRH = 20;                             % Quantity of RRHs
P_BBUpool = 3000;                      % Price per BBU Pool
N_BBUpool = 5;                         % Quantity of BBU Pools
TOT_EQcost = 0;                        % Total equipment cost

EQ_price = [P_RRH P_BBUpool];
EQ_quant = [N_RRH N_BBUpool];


for i = 1:length(EQ_price)
        TOT_EQcost = TOT_EQcost + EQ_price(i)*EQ_quant(i);
end

%% - Infrastructure Cost
% Deployment of fiber infrastructure, cost of leasing fibers and installation of RRH's

global TOT_PTPCost;
global TOT_LeaseFiberCost;
global TOT_InfraCost;

TOT_TrenchDist = 10;                 % Total distance to be trenched
FiberTrench_KM = 130000;             % Trenching price per Km
FiberLenght_KM = 30;                 % Total lenght of fiber needed
FiberPrice = 160;                    % Price of fiber per KM

TOT_LeaseDist = 0;                   % Total lenght of leased fiber
FiberLease_KM = 200;                 % Leasing price per KM

TOT_PTPCost = TOT_TrenchDist * FiberTrench_KM + FiberLenght_KM * FiberPrice;
TOT_LeaseFiberCost = TOT_LeaseDist * FiberLease_KM;

TOT_InfraCost = TOT_PTPCost + TOT_LeaseFiberCost;

%% - Installation Cost
% Expenses related to installing the backhaul components in their locations


%% --- OPEX --- %%

%% - Energy Cost
% Yearly energy cost of all active equipment

global Yearly_kW;                   % Yearly kW consumed by equipments
global Price_kW;                    % Price per kW
global TOT_EnergyCost;                % Total energy cost

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