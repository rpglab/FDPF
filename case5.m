%% case5
%    A test case as shown in Fig. 2.8 on page 95 in Chapter 2.3 in the following book:
%    Xi-Fan Wang, Yonghua Song, and Malcolm Irving, "Modern Power Systems
%    Analysis", Springer; 2009th edition (December 14, 2011). 

%% bus data format
% 1.bus number  2.bus type  3.G (G=0)  4.B (B=0) 
% 5.voltage magnitude  6.voltage angle in degree
bus = [
1 1 0 0 1 0
2 1 0 0 1 0
3 1 0 0 1 0
4 2 0 0 1.05 0
5 3 0 0 1.05 0 ];


%% branch data format
%  1.fromBusNum   2.toBusNum    3.R      4.X  
%  5.G/2 (=0)  6. (B/2)  7.tap=1
branch = [
1 2 0.04 0.25 0 0.25 1
1 3 0.1 0.35 0 0 1
2 3 0.08 0.30 0 0.25 1 ];

%% transformer data format
% 1.fromBusNum   2.toBusNum  3.RT  4.XT
% 5.GT  6.BT  7.tap
transformer = [
2 4 0 0.015 0 0 1.05
3 5 0 0.03 0 0 1.05  ];

%% gen data format
% 1.genNum 2.active output 3.reactive output
gen = [ 
4 5 0
5 0 0 ];

%% load data format
% 1.busNum 2.active load 3.reactive load
load = [
1 1.6 0.8
2 2 1
3 3.7 1.3  ];

%% shunt data format if any
% 1.busNum  2.G  3.B





