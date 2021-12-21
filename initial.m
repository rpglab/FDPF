%% Fast decoupled power flow program 
%  by Xingpeng Li, xplipower@gmail.com
%    Website: https://rpglab.github.io/

%% data format introduction
% bus data format
%    1.bus number  2.bus type  3.G (G=0)  4.B (B=0) 5.Vm 6.angle
%        For bus type: 1 denotes PQ bus; 2 denotes PV bus; 3 denotes slack bus
% branch data format
%    1.fromBusNum   2.toBusNum   3.R   4.X   5.G/2 (=0)  6. (B/2)  7.tap=1
% transformer data format
%    1.fromBusNum   2.toBusNum  3.RT  4.XT  5.GT  6.BT  7.tap
% shunt data format
%    1.busNum  2.G  3.B
% load data format
%    1.busNum 2.active load 3.reactive load
% gen data format
%    1.genBusNum 2.active power output 3.reactive power output

%% PF Parameter Setting
% Set stopping criterion (precision threshold) for iterations
epsilon = 1e-3;    

% Set allowed max number of interations
maxIter = 100;  % FYI: if an AC power flow problem does not converge within 10 or 15 iterations, then, most likely it will never converge.

% Initial conditions
bus = [];
branch = [];
gen = [];
transformer = [];
shunt = [];
load = [];

%% Load a test case
%   input test case data are from .m file
%   The code below will pop up a dialog box for users to choose a .m test case.
%      Note that currenting code only finds a test case file starting with
%      'case' and ending with '.m'.
[dfile,pathname]=uigetfile('case*.m','Select Data File');
if pathname == 0
  error(' You must select a valid data file')
else
  lfile =length(dfile);
  eval(dfile(1:lfile-2));
end
disp(dfile);
tic

% check for valid data file
if isempty(bus) || isempty(branch)
   error(' The selected file is not a valid data file');
end

% consider transformer as a special branch
if ~isempty(transformer)
    branch = [branch;transformer];
end

% Put PV buses to the end;
PVtemp = find (bus(:,2) == 2); 
busPVtemp = bus(PVtemp,:);
bus(PVtemp,:) = [];
bus = [bus;busPVtemp];

% Put slack buses to the end;
slacktemp = find (bus(:,2) == 3); 
busslacktemp = bus(slacktemp,:);
bus(slacktemp,:) = [];
bus = [bus;busslacktemp];

%% define basic system parameters
nb = size(bus,1);
nl = size(branch,1);
nG = size(gen,1);

%% bus number re-index
origBusIndex = bus(:, 1);
orderedBusIndex = zeros(max(origBusIndex), 1);
orderedBusIndex(origBusIndex) = (1:size(bus, 1))';  % from 1 to number-of-buses

bus(:, 1)     =   orderedBusIndex( bus(:, 1)      );
gen(:, 1)     =   orderedBusIndex( gen(:, 1)      );
branch(:, 1)  =   orderedBusIndex( branch(:, 1)   );    
branch(:, 2)  =   orderedBusIndex( branch(:, 2)   );    
load(:, 1)    =   orderedBusIndex( load(:, 1)     );    

% Put the shunt into the bus data (3rd column and 4th column)
if ~isempty(shunt)
    shunt(:, 1)   =   orderedBusIndex( shunt(:, 1)    );    
    bus(:,3) = bus(:,3) + sparse(shunt(:,1), 1, shunt(:,2), nb, 1);
    bus(:,4) = bus(:,4) + sparse(shunt(:,1), 1, shunt(:,3), nb, 1);
end

%% Initionization
slack = find (bus(:,2) == 3); 
PVbus = find(bus(:,2) == 2);
busPVandSlack = [PVbus;slack];  

Vm = bus(:,5);    % initial point for Vm
ang = bus(:,6);   % initial point for angle 

if initPtOption == 2
    Vm(busPVandSlack) = bus(busPVandSlack,5);
    Vm(busPVandSlack) = 1.0;
    ang(:) = 0.0;
    ang(slack) = bus(slack,6);
end
ang = ang * pi /180;

Genf = gen(:,1); 
GenP = gen(:,2); 
GenQ = gen(:,3); 

Loadf = load(:,1); 
LoadP = load(:,2);
LoadQ = load(:,3);

% bus injection active power
PiG = sparse(Genf,1,GenP,nb,1); 
PiL = sparse(Loadf,1,LoadP,nb,1); 
Pis = PiG - PiL;

% bus injection reactive power
QiG = sparse(Genf,1,GenQ,nb,1); 
QiL = sparse(Loadf,1,LoadQ,nb,1); 
Qis = QiG - QiL;        

