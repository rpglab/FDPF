%% Fast decoupled power flow program 
%    It works well for transmission networks where line resistance is much smaller than line reactance;
%  by Xingpeng Li (xplipower@gmail.com)
%    Website: https://rpglab.github.io/

clear
clc
format long

%% PF method setting
showDetailResults = false;  % true or false
alg = 2;    % algorithm option
            % alg = 1: when converged, we may solve deltaP correction equations one more time than deltaQ correction equations.
            % alg = 2: when converged, we will solve deltaP correction equations the same times with deltaQ correction equations.
initPtOption = 1;   % initial point for Vm and angle to start the AC power flow iteration            
                    % initPtOption = 1: use the values given in the bus data
                    % initPtOption = 2: use flat start
option = 0; % option = 0: traditional Bpbus and Bppbus will be used
            % option = 1: (INCORRECT option) take the imaginary part of Ybus to form B' and B'' (PF may diverge)


%% Initializtion & Pre-processing
initial   % power flow paramaters are also set in this 'initial' code.

%% Form the Ybus, B' and B'' matrices
FormYbus  
if (option == 0)
    FormBpbus 
    FormBppbus
elseif (option == 1)
    FormBpBppbus   % incorrect option
end

%% Iteration process
% Iteration initialization
VmPVandslack = Vm(nb - size(busPVandSlack,1) + 1 : nb); % Vm for PV buses will not change
angP = ang;
angP(slack) = [];
angslack = ang(slack); % not sure it works if multiple slack buses exit; to be tested
error = [1, 1]';  % for both P mismatch & Q mismatch; initialize it to large numbers 
errorPP = [];
errorQQ = [];

if alg == 1
    runAlg1
else
    runAlg2
end
toc  

%% Plot the power (P & Q) mismatch over iterations
K01nQ = 0;
if (nk == maxIter)
    disp('Fast Decoupled Power Flow iterative calculation do not converge');
else          
    fprintf(1,'converge after %d iterations\n',nk); 
    if alg == 1
        if convFlag == 0
            disp( 'converge after iterations of the first correction equation: dP/U = B''*(U * dang)');
            K01nQ = 1; 
        else 
            disp('converge after iterations of the first correction equation: dQ/U = B''''*[dU]');
            K01nQ = 0;
        end
    end
end
% Result figures
nP = [1:nk]';
subplot(2,1,1),semilogy(nP,abs(errorPP));grid;xlabel('Iteration');ylabel('dP/Vm');
nQ = [1:(nk-K01nQ)]';
%subplot(2,1,2),plot(nQ,abs(errorQQ)); grid; xlabel('Iteration');ylabel('dQ/Vm');
subplot(2,1,2),semilogy(nQ,abs(errorQQ)); grid; xlabel('Iteration');ylabel('dQ/Vm');

%% Retrieve and recover original bus number for all elements
Vm = Vm(orderedBusIndex(:, 1));
ang = ang(orderedBusIndex(:, 1));

bus(:, 1)     =   origBusIndex( bus(:, 1)      );
gen(:, 1)     =   origBusIndex( gen(:, 1)      );
branch(:, 1)  =   origBusIndex( branch(:, 1)   );    
branch(:, 2)  =   origBusIndex( branch(:, 2)   );    
load(:, 1)    =   origBusIndex( load(:, 1)     );    

%% Calculate additional power flow results
calcLineFlow
calcBusInj

ang_degree = ang * 180 /pi ;  % radian to degree
