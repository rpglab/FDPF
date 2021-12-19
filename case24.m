%% IEEE 24-bus test case (RTS-96)
%   This case is modified from the Matpower case24_ieee_rts.m file.
%
%   Originally, the system data for this case is the IEEE RELIABILITY TEST SYSTEM, see
%
%   IEEE Reliability Test System Task Force of the Applications of
%   Probability Methods Subcommittee, "IEEE reliability test system,"
%   IEEE Transactions on Power Apparatus and Systems, Vol. 98, No. 6,
%   Nov./Dec. 1979, pp. 2047-2054.
%
%   IEEE Reliability Test System Task Force of Applications of
%   Probability Methods Subcommittee, "IEEE reliability test system-96,"
%   IEEE Transactions on Power Systems, Vol. 14, No. 3, Aug. 1999,
%   pp. 1010-1020.

%% bus data format
% 1.bus number  2.bus type  3.G_at_bus (G=0)  4.B_at_bus (B=0) 
% 5.Vm 6.angle (in degree)
% for bus type: 1 denotes PQ bus; 2 denotes PV bus; 3 denotes slack bus
bus = [
1	2	0	0	1.035	0
2	2	0	0	1.035	0
3	1	0	0	1	0
4	1	0	0	1	0
5	1	0	0	1	0
6	1	0	-100	1	0
7	2	0	0	1.025	0
8	1	0	0	1	0
9	1	0	0	1	0
10	1	0	0	1	0
11	1	0	0	1	0
12	1	0	0	1	0
13	3	0	0	1.02	0
14	2	0	0	0.98	0
15	2	0	0	1.014	0
16	2	0	0	1.017	0
17	1	0	0	1	0
18	2	0	0	1.05	0
19	1	0	0	1	0
20	1	0	0	1	0
21	2	0	0	1.05	0
22	2	0	0	1.05	0
23	2	0	0	1.05	0
24	1	0	0	1	0
];
bus(:,3) = bus(:,3) / 100;
bus(:,4) = bus(:,4) / 100;

%% branch data format (may include transformer data here)
%  1.fromBusNum   2.toBusNum    3.R      4.X  
%  5.G/2 (=0)  6. (B/2)  7.tap=1
branch = [
1	2	0.0026	0.0139	0	0.23055	0
1	3	0.0546	0.2112	0	0.0286	0
1	5	0.0218	0.0845	0	0.01145	0
2	4	0.0328	0.1267	0	0.01715	0
2	6	0.0497	0.192	0	0.026	0
3	9	0.0308	0.119	0	0.0161	0
3	24	0.0023	0.0839	0	0	1.03
4	9	0.0268	0.1037	0	0.01405	0
5	10	0.0228	0.0883	0	0.01195	0
6	10	0.0139	0.0605	0	1.2295	0
7	8	0.0159	0.0614	0	0.0083	0
8	9	0.0427	0.1651	0	0.02235	0
8	10	0.0427	0.1651	0	0.02235	0
9	11	0.0023	0.0839	0	0	1.03
9	12	0.0023	0.0839	0	0	1.03
10	11	0.0023	0.0839	0	0	1.02
10	12	0.0023	0.0839	0	0	1.02
11	13	0.0061	0.0476	0	0.04995	0
11	14	0.0054	0.0418	0	0.04395	0
12	13	0.0061	0.0476	0	0.04995	0
12	23	0.0124	0.0966	0	0.1015	0
13	23	0.0111	0.0865	0	0.0909	0
14	16	0.005	0.0389	0	0.0409	0
15	16	0.0022	0.0173	0	0.0182	0
15	21	0.0063	0.049	0	0.0515	0
15	21	0.0063	0.049	0	0.0515	0
15	24	0.0067	0.0519	0	0.05455	0
16	17	0.0033	0.0259	0	0.02725	0
16	19	0.003	0.0231	0	0.02425	0
17	18	0.0018	0.0144	0	0.01515	0
17	22	0.0135	0.1053	0	0.1106	0
18	21	0.0033	0.0259	0	0.02725	0
18	21	0.0033	0.0259	0	0.02725	0
19	20	0.0051	0.0396	0	0.04165	0
19	20	0.0051	0.0396	0	0.04165	0
20	23	0.0028	0.0216	0	0.02275	0
20	23	0.0028	0.0216	0	0.02275	0
21	22	0.0087	0.0678	0	0.0712	0
];
idxBrc = find(branch(:,7) == 0);
branch(idxBrc,7) = 1;

%% transformer data format
% 1.fromBusNum   2.toBusNum  3.RT  4.XT
% 5.GT  6.BT  7.tap

%% gen data format
% 1.genBusNum 2.active output 3.reactive output
gen = [ 
1	10	0
1	10	0
1	76	0
1	76	0
2	10	0
2	10	0
2	76	0
2	76	0
7	80	0
7	80	0
7	80	0
13	95.1	0
13	95.1	0
13	95.1	0
14	0	35.3
15	12	0
15	12	0
15	12	0
15	12	0
15	12	0
15	155	0
16	155	0
18	400	0
21	400	0
22	50	0
22	50	0
22	50	0
22	50	0
22	50	0
22	50	0
23	155	0
23	155	0
23	350	0
];
gen(:,2) = gen(:,2) / 100;
gen(:,3) = gen(:,3) / 100;

%% load data format
% 1.busNum 2.active power load 3.reactive power load
load = [
1	108	22
2	97	20
3	180	37
4	74	15
5	71	14
6	136	28
7	125	25
8	171	35
9	175	36
10	195	40
11	0	0
12	0	0
13	265	54
14	194	39
15	317	64
16	100	20
17	0	0
18	333	68
19	181	37
20	128	26
21	0	0
22	0	0
23	0	0
24	0	0
];
load(:,2) = load(:,2) / 100;
load(:,3) = load(:,3) / 100;

%% shunt data format if any
% 1.busNum  2.G  3.B





