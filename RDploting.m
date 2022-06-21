

%% RD ploting

%all none B=4
tElapsed11 =[236.3621  197.0320  358.4543  288.5968  261.3360  252.9651];
SizE11 =[8928160     6985176     6363576     6189600     6129352     6120656];
bitRate11 =[4.1938    3.2811    2.9891    2.9074    2.8791    2.8750];
avrgPSNR11 =[38.4515   32.2451   27.9025   24.9471   23.1736   22.2949];
avrgCOST11 =[11.2209   39.7552  106.1039  208.7649  313.7951  383.9370];
%all intra B=4
tElapsed22 =[681.3213  636.2811  474.9037  311.0653  302.5722  297.3892];
SizE22 =[8569928     6771832     6250224     6118952     6085592     6084544];
bitRate22 =[4.0255    3.1809    2.9359    2.8742    2.8586    2.8581];
avrgPSNR22 =[38.1023   31.7993   27.1623   24.4783   22.1662   21.5823];
avrgCOST22 =[11.8172   43.8389  125.5886  232.4231  395.5349  453.1738];
   
QuantStep=[ 10  30  70  120  180 200];  
%all none  B=16
tElapsed1 =[95.8735   43.3796   25.5283   19.9016   19.8156   18.6191]
SizE1 =[3560584     1388816      760920      569208      490392      475728]
bitRate1 =[1.6725    0.6524    0.3574    0.2674    0.2304    0.2235]
avrgPSNR1 =[37.8885   32.0040   28.0705   25.6560   23.9731   23.5682]
avrgCOST1 =[36.2398   49.5503  105.0847  179.0474  262.2236  287.6886]

%all intra B=16
tElapsed2 =[175.6260  129.3222  110.9515  105.3253  105.1820  103.4554]
SizE2 =[3629000     1404416      743264      546640      465664      450232]
bitRate2 =[1.7046    0.6597    0.3491    0.2568    0.2187    0.2115]
avrgPSNR2 =[37.8230   31.9641   27.9359   25.4488   23.7251   23.3160]
avrgCOST2 =[36.9393   50.0506  108.1450  187.5368  277.2665  304.5338]

% none PPP B=16

tElapsed3 =1.0e+03 *[1.0363    1.0238    0.9758    0.9745    0.9722    0.9748];
SizE3 =[2286464      948840      667168      585712      558968      556200];
bitRate3 =[1.0740    0.4457    0.3134    0.2751    0.2626    0.2613];
avrgPSNR3 =[35.3747   30.0609   26.6618   24.6845   23.4601   23.1165];
avrgCOST3 =[43.8779   73.3160  146.8355  226.8523  297.9880  321.9070];

% intra PPP B=16

tElapsed4 =1.0e+03 *[1.0038    0.9862    0.9820    0.9812    0.9820    0.9784]
SizE4 =[2308472      955472      671976      585192      558456      552984]
bitRate4 =[1.0844    0.4488    0.3156    0.2749    0.2623    0.2598]
avrgPSNR4 =[35.3493   30.0531   26.6097   24.6128   23.3683   23.0609]
avrgCOST4 =[44.1765   73.4361  148.4213  230.1699  303.9453  325.7485]

%%
figure;
plot(bitRate1,avrgPSNR1,'-xr',bitRate2,avrgPSNR2,'-xb',bitRate3,avrgPSNR3,'-xg',bitRate4,avrgPSNR4,'-xk');
title('PSNR vs Rate');xlabel('Bit Rate bpp'); ylabel('PSNR dB');
legend('IIII all none B=16 ','IIII all intra B=16','none+PPP  B=16 ','intra+PPP  B=16 ');

figure;
subplot(121),plot(QuantStep,avrgPSNR1,'-xr',QuantStep,avrgPSNR2,'-xb',QuantStep,avrgPSNR3,'-xg',QuantStep,avrgPSNR4,'-xk');
title('PSNR vs QuantStep ');xlabel('quant step'); ylabel('PSNR dB');
legend('IIII all none B=16 ','IIII all intra B=16','none+PPP  B=16 ','intra+PPP  B=16 ');

subplot(122),plot(QuantStep,bitRate1,'-xr',QuantStep,bitRate2,'-xb',QuantStep,bitRate3,'-xg',QuantStep,bitRate4,'-xk');
title('Bit Rate vs QuantStep');xlabel('quant step'); ylabel('Bit Rate bpp');
legend('IIII all none B=16 ','IIII all intra B=16','none+PPP  B=16 ','intra+PPP  B=16 ');

%%
%%
figure;
plot(bitRate1,avrgPSNR1,'-xr',bitRate2,avrgPSNR2,'-xb',bitRate11,avrgPSNR11,'-xg',bitRate22,avrgPSNR22,'-xk');
title('PSNR vs Rate');xlabel('Bit Rate bpp'); ylabel('PSNR dB');
legend('IIII all none B=16 ','IIII all intra B=16','IIII all none  B=4 ','IIII all intra   B=4 ');

figure;
subplot(121),plot(QuantStep,avrgPSNR1,'-xr',QuantStep,avrgPSNR2,'-xb',QuantStep,avrgPSNR11,'-xg',QuantStep,avrgPSNR22,'-xk');
title('PSNR vs QuantStep ');xlabel('quant step'); ylabel('PSNR dB');
legend('IIII all none B=16 ','IIII all intra B=16','IIII all none  B=4 ','IIII all intra   B=4 ');

subplot(122),plot(QuantStep,bitRate1,'-xr',QuantStep,bitRate2,'-xb',QuantStep,bitRate11,'-xg',QuantStep,bitRate22,'-xk');
title('Bit Rate vs QuantStep');xlabel('quant step'); ylabel('Bit Rate bpp');
legend('IIII all none B=16 ','IIII all intra B=16','IIII all none  B=4 ','IIII all intra   B=4 ');
