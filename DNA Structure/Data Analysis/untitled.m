Percent_Occupancy_24=[55.2	18.5	7.39	15.9
80.5	17.2	1.8	0.553
75.9	21.6	1.74	0.634
78.2	19.3	1.15	1.15
76.6	19.8	1.71	1.71
79.3	19.5	0.909	0.182
76.3	21.1	2.06	0.343
78.9	19.3	1.15	0.659
42.9	46	9.32	1.04
43.4	42.2	10.4	3.12
46.3	39.5	11.2	1.83
44.1	42.1	9.21	1.88
43.1	44	8.32	2.55
41.7	45.1	9.21	2.18
46.9	41.6	8.43	2.3
25.5	40.1	15	16
26.1	46.2	15.7	8.87
36.2	51.1	12.7	0
30.7	51	13.7	3.21
31.9	50.3	13.3	3.43
30.9	54.5	10.1	2.74
27.2	57.7	12.1	1.59
26.4	52.1	15.4	3.59
31.2	37.7	15.5	11.8];

Percent_Occupancy_48=[26.8	44.7	11.9	3.21	3.81
28.8	44.8	11	2.38	3.24
29.8	44.7	11.7	2.49	2.39
29.4	44.6	9.67	3.15	3.38
30	44.2	9.8	2.81	3.08
28	45.3	9.25	2.33	3.52
26.9	45.2	10.3	1.76	3.67
26.9	42.5	9.52	2.81	5.01
5.42	33	28.6	10.8	3.29
7.89	31.6	28.1	10.9	2.03
4.5	32.9	30.5	10.6	2.68
5.5	34.8	29.9	10.5	3
5.97	32.4	28	9.93	2.98
5.08	32.3	28.1	10.9	2.94
6.3	32.5	27.3	10.6	2.54
6.06	32.8	24.2	9.38	3.05
0.0711	1.28	16.3	53.4	23.2
0.119	1.24	15.1	54.7	23.1
0.147	1.38	12.8	53.1	20.9
0.185	2.09	12.1	45.2	19.5
0.159	1.68	15	53.5	23.4
0.172	1.67	14.5	52.9	23
0.213	1.3	14.8	52.7	23.6
0.0823	1.49	14.4	53	23.5
];

Peak24=[1 2 3 4];
Peak48=[1 2 3 4 5];

i_1ug=[1 2 3 4 5 6 7 8];
i_10ug=[9 10 11 12 13 14 15 16];
i_100ug=[17 18 19 20 21 22 23 24];

Percent_Occupancy_24_1ug=Percent_Occupancy_24(i_1ug,:)
Percent_Occupancy_24_10ug=Percent_Occupancy_24(i_10ug,:)
Percent_Occupancy_24_100ug=Percent_Occupancy_24(i_100ug,:)

Percent_Occupancy_48_1ug=Percent_Occupancy_48(i_1ug,:)
Percent_Occupancy_48_10ug=Percent_Occupancy_48(i_10ug,:)
Percent_Occupancy_48_100ug=Percent_Occupancy_48(i_100ug,:)

%%
figure()
hold on
plot(Peak24, Percent_Occupancy_24_1ug, '-bo')
plot(Peak24, Percent_Occupancy_24_10ug, '-go')
plot(Peak24, Percent_Occupancy_24_100ug, '-ro')
set(gcf, 'color', [1 1 1])
Xlabel('Peak')
Ylabel('Percent Occupancy')
Title('Percent Occupancy at 24 hours')

figure()
hold on
plot(Peak48, Percent_Occupancy_48_1ug, '-bo')
plot(Peak48, Percent_Occupancy_48_10ug, '-go')
plot(Peak48, Percent_Occupancy_48_100ug, '-ro')
set(gcf, 'color', [1 1 1])
Xlabel('Peak')
Ylabel('Percent Occupancy')
Title('Percent Occupancy at 48 hours')