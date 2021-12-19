%% This code is to verify the AC power flow results 
%    with the results obtained with Matpower

%                        total P loss (in MW)  |  total Q loss (in MVAr)
% This program                 51.34                    458.11
% Matpower (NR method)         51.25                    454.77

% The maximum absolute difference for voltage magnitude is:       4.899599878942507e-04
% The maximum absolute difference for voltage angle (degree) is:  4.546501842297435e-04

% Data format
% 1.bus number  2.Vm 3.ang in degree  
results_Matpower = [
1	1.035	-7.278
2	1.035	-7.37
3	0.989	-5.584
4	0.998	-9.69
5	1.019	-9.964
6	1.012	-12.421
7	1.025	-7.357
8	0.993	-11.088
9	1.001	-7.435
10	1.028	-9.503
11	0.99	-2.154
12	1.003	-1.517
13	1.02	0.000
14	0.98	2.258
15	1.014	11.566
16	1.017	10.449
17	1.039	14.931
18	1.05	16.292
19	1.023	8.917
20	1.038	9.53
21	1.05	17.117
22	1.05	22.766
23	1.05	10.572
24	0.978	5.299
];

Vm_verify = results_Matpower(:,2);
errorVm = abs(Vm_verify - Vm);
maxerrorVm = max(errorVm)

ang_verify = results_Matpower(:,3);
errorang = abs(ang_verify - ang_degree);
maxerrorang = max(errorang)





