%% This code is to verify the AC power flow results 
%    with the results obtained with Matpower

%                        total P loss (in MW)  |  total Q loss (in MVAr)
% This program                 46.33                    1061.47
% Matpower (NR method)         43.64                    1000.59

% The maximum absolute difference for voltage magnitude is:       4.999999999999449e-04
% The maximum absolute difference for voltage angle (degree) is:  4.923768050713040e-04

% The average absolute difference for voltage magnitude is:       2.560552529754369e-04
% The average absolute difference for voltage angle (degree) is:  2.545340345176096e-04

% Data format
% 1.bus number  2.Vm 3.ang in degree  
results_Matpower = [
1	1.039	-13.537
2	1.048	-9.785
3	1.031	-12.276
4	1.004	-12.627
5	1.006	-11.192
6	1.008	-10.408
7	0.998	-12.756
8	0.998	-13.336
9	1.038	-14.178
10	1.018	-8.171
11	1.013	-8.937
12	1.001	-8.999
13	1.015	-8.93
14	1.012	-10.715
15	1.016	-11.345
16	1.033	-10.033
17	1.034	-11.116
18	1.032	-11.986
19	1.05	-5.41
20	0.991	-6.821
21	1.032	-7.629
22	1.05	-3.183
23	1.045	-3.381
24	1.038	-9.914
25	1.058	-8.369
26	1.053	-9.439
27	1.038	-11.362
28	1.05	-5.928
29	1.05	-3.17
30	1.05	-7.37
31	0.982	0.000
32	0.984	-0.188
33	0.997	-0.193
34	1.012	-1.631
35	1.049	1.777
36	1.064	4.468
37	1.028	-1.583
38	1.026	3.893
39	1.03	-14.535
];

Vm_verify = results_Matpower(:,2);
errorVm = abs(Vm_verify - Vm);
maxerrorVm = max(errorVm)
meanerrorVm = mean(errorVm)

ang_verify = results_Matpower(:,3);
errorang = abs(ang_verify - ang_degree);
maxerrorang = max(errorang)
meanerrorang = mean(errorang)




