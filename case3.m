%% 3-bus test case 
%   from ECE6379 HW-3 Problem-1
%   by Xingpeng Li
%   at University of Houston, 2021 Fall

%% bus data format
% 1.bus number  2.bus type  3.G_at_bus (G=0)  4.B_at_bus (B=0) 
% 5.Vm 6.angle (in degree)
% for bus type: 1 denotes PQ bus; 2 denotes PV bus; 3 denotes slack bus
bus = [
1  3  0  0  1.03  0
2  1  0  0  1  0
3  2  0  0  1.01  0 ];

%% branch data format
%  1.fromBusNum   2.toBusNum    3.R      4.X  
%  5.G/2 (=0)  6. (B/2)  7.tap=1
branch = [
1   2   0.02    0.1    0    0   1
1   3   0.015   0.1    0    0   1
2   3   0.01    0.06   0    0   1];

%% transformer data format
% 1.fromBusNum   2.toBusNum  3.RT  4.XT
% 5.GT  6.BT  7.tap

%% gen data format
% 1.genBusNum 2.active output 3.reactive output
gen = [ 
1   1.04   0.31
3   1.2    0.35];

%% load data format
% 1.busNum 2.active power load 3.reactive power load
load = [
2   1.4   0.45  
3   0.8   0.2  ];

%% shunt data format if any
% 1.busNum  2.G  3.B





