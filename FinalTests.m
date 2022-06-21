%% 
clc, clear, close all;

savedVideoFileName='myCompressedVideo.bin';
delete(savedVideoFileName);

sequenceName = 'foreman';resolution = 'cif';colorspace = 'y';
videoFileName = [sequenceName '_' resolution '.' colorspace];

%%  all none but diff blk size , same delta
      tic;  
      currentIMG= readFrame(videoFileName,5);
      [EncodedImgBitStream1, reconstactedIMG(:,:,1), cost(1),mse(1),head1] = getFrameI(currentIMG,4,30,'none'); tElapsed1 = toc;
      [EncodedImgBitStream2, reconstactedIMG(:,:,2), cost(2),mse(2),head2] = getFrameI(currentIMG,8,30,'none'); tElapsed2 = toc;
      [EncodedImgBitStream3, reconstactedIMG(:,:,3), cost(3),mse(3),head3] = getFrameI(currentIMG,16,30,'none'); tElapsed3 = toc;
      [EncodedImgBitStream4, reconstactedIMG(:,:,4), cost(4),mse(4),head4] = getFrameI(currentIMG,32,30,'none'); tElapsed4 = toc;
      psnr=10*log10(255^2./mse);
      time(1)=tElapsed1;
      time(2)=tElapsed2-tElapsed1;
      time(3)=tElapsed3-tElapsed2;
      time(4)=tElapsed4-tElapsed3;
      % 
      s(1)=length(EncodedImgBitStream1);
      s(2)=length(EncodedImgBitStream2);
      s(3)=length(EncodedImgBitStream3);
      s(4)=length(EncodedImgBitStream4);
      
figure; 
subplot(221),image(uint8(reconstactedIMG(:,:,1))); title(['Blk=4, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(222),image(uint8(reconstactedIMG(:,:,2))); title(['Blk=8, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG(:,:,3))); title(['Blk=16, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(224),image(uint8(reconstactedIMG(:,:,4))); title(['Blk=32, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
%%  all intra but diff blk size , same delta
      tic;  
      currentIMG= readFrame(videoFileName,5);
      [EncodedImgBitStream1, reconstactedIMG(:,:,1), cost(1),mse(1),head1] = getFrameI(currentIMG,4,30,'intra'); tElapsed1 = toc;
      [EncodedImgBitStream2, reconstactedIMG(:,:,2), cost(2),mse(2),head2] = getFrameI(currentIMG,8,30,'intra'); tElapsed2 = toc;
      [EncodedImgBitStream3, reconstactedIMG(:,:,3), cost(3),mse(3),head3] = getFrameI(currentIMG,16,30,'intra'); tElapsed3 = toc;
      [EncodedImgBitStream4, reconstactedIMG(:,:,4), cost(4),mse(4),head4] = getFrameI(currentIMG,32,30,'intra'); tElapsed4 = toc;
      psnr=10*log10(255^2./mse);
      time(1)=tElapsed1;
      time(2)=tElapsed2-tElapsed1;
      time(3)=tElapsed3-tElapsed2;
      time(4)=tElapsed4-tElapsed3;
      % 
      s(1)=length(EncodedImgBitStream1);
      s(2)=length(EncodedImgBitStream2);
      s(3)=length(EncodedImgBitStream3);
      s(4)=length(EncodedImgBitStream4);
      
figure; 
subplot(221),image(uint8(reconstactedIMG(:,:,1))); title(['Blk=4, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(222),image(uint8(reconstactedIMG(:,:,2))); title(['Blk=8, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG(:,:,3))); title(['Blk=16, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(224),image(uint8(reconstactedIMG(:,:,4))); title(['Blk=32, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;

%%  all none but diff quant step, same blk size

      tic;  
      currentIMG= readFrame(videoFileName,5);
      [EncodedImgBitStream1, reconstactedIMG(:,:,1), cost(1),mse(1),head1] = getFrameI(currentIMG,8,25,'none'); tElapsed1 = toc;
      [EncodedImgBitStream2, reconstactedIMG(:,:,2), cost(2),mse(2),head2] = getFrameI(currentIMG,8,50,'none'); tElapsed2 = toc;
      [EncodedImgBitStream3, reconstactedIMG(:,:,3), cost(3),mse(3),head3] = getFrameI(currentIMG,8,75,'none'); tElapsed3 = toc;
      [EncodedImgBitStream4, reconstactedIMG(:,:,4), cost(4),mse(4),head4] = getFrameI(currentIMG,8,100,'none'); tElapsed4 = toc;
      psnr=10*log10(255^2./mse);
      time(1)=tElapsed1;
      time(2)=tElapsed2-tElapsed1;
      time(3)=tElapsed3-tElapsed2;
      time(4)=tElapsed4-tElapsed3;
      % 
      s(1)=length(EncodedImgBitStream1);
      s(2)=length(EncodedImgBitStream2);
      s(3)=length(EncodedImgBitStream3);
      s(4)=length(EncodedImgBitStream4);
      
figure; 
subplot(221),image(uint8(reconstactedIMG(:,:,1))); title(['B=8 Q=25, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(222),image(uint8(reconstactedIMG(:,:,2))); title(['B=8 Q=50, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG(:,:,3))); title(['B=8 Q=75, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(224),image(uint8(reconstactedIMG(:,:,4))); title(['B=8 Q=100, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: none'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;

%%  all intra but diff quant step, same blk size

      tic;  
      currentIMG= readFrame(videoFileName,5);
      [EncodedImgBitStream1, reconstactedIMG(:,:,1), cost(1),mse(1),head1] = getFrameI(currentIMG,8,25,'intra'); tElapsed1 = toc;
      [EncodedImgBitStream2, reconstactedIMG(:,:,2), cost(2),mse(2),head2] = getFrameI(currentIMG,8,50,'intra'); tElapsed2 = toc;
      [EncodedImgBitStream3, reconstactedIMG(:,:,3), cost(3),mse(3),head3] = getFrameI(currentIMG,8,75,'intra'); tElapsed3 = toc;
      [EncodedImgBitStream4, reconstactedIMG(:,:,4), cost(4),mse(4),head4] = getFrameI(currentIMG,8,100,'intra'); tElapsed4 = toc;
      psnr=10*log10(255^2./mse);
      time(1)=tElapsed1;
      time(2)=tElapsed2-tElapsed1;
      time(3)=tElapsed3-tElapsed2;
      time(4)=tElapsed4-tElapsed3;
      % 
      s(1)=length(EncodedImgBitStream1);
      s(2)=length(EncodedImgBitStream2);
      s(3)=length(EncodedImgBitStream3);
      s(4)=length(EncodedImgBitStream4);
      
figure; 
subplot(221),image(uint8(reconstactedIMG(:,:,1))); title(['B=8 Q=25, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(222),image(uint8(reconstactedIMG(:,:,2))); title(['B=8 Q=50, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG(:,:,3))); title(['B=8 Q=75, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(224),image(uint8(reconstactedIMG(:,:,4))); title(['B=8 Q=100, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: intra'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;

%%  one P but diff blk size, same Quant step , carfull blk=4 take alot of time , even =8 this is why i comment it

tic;  
currentIMG= readFrame(videoFileName,10);
refImg = readFrame(videoFileName,1);

tic; [EncodedImgBitStream1,MotionVectsBitStream1,reconstactedIMG2(:,:,1), cost(1),mse(1),head1] = getFrameP(currentIMG,refImg,128,128,4,30);   tElapsed1 = toc;
tic; [EncodedImgBitStream2,MotionVectsBitStream2,reconstactedIMG2(:,:,2), cost(2),mse(2),head2] = getFrameP(currentIMG,refImg,128,128,8,30);   tElapsed2 = toc;    
tic; [EncodedImgBitStream3,MotionVectsBitStream3,reconstactedIMG2(:,:,3), cost(3),mse(3),head3] = getFrameP(currentIMG,refImg,128,128,16,30);  tElapsed3 = toc;
tic; [EncodedImgBitStream4,MotionVectsBitStream4,reconstactedIMG2(:,:,4), cost(4),mse(4),head4] = getFrameP(currentIMG,refImg,128,128,32,30);  tElapsed4 = toc;    

psnr=10*log10(255^2./mse);

     time(1)=tElapsed1;
       time(2)=tElapsed2;
      time(3)=tElapsed3;
      time(4)=tElapsed4;
      % 
       s(1)=length(EncodedImgBitStream1)+length(MotionVectsBitStream1);
       s(2)=length(EncodedImgBitStream2)+length(MotionVectsBitStream2);
      s(3)=length(EncodedImgBitStream3)+length(MotionVectsBitStream3);
      s(4)=length(EncodedImgBitStream4)+length(MotionVectsBitStream4);
      %%
      c0=0;c1=0;c2=0;c3=0;c4=0;c5=0;
      for i=1:size(head4,1)
          if head4(i,4)== 0, c0=c0+1; 			% mode none
          elseif head4(i,4)== 1, c1=c1+1;		% mode inter
          elseif head4(i,4)== 2, c2=c2+1;		% mode intra Vertical Replication
          elseif head4(i,4)== 3, c3=c3+1;		% mode intra Horizonatal 
          elseif head4(i,4)== 4, c4=c4+1;		% mode intra DC (mean mode)
          elseif head4(i,4)== 5, c5=c5+1;		% mode intra (min or max or a+b-c)
          end
      end
      %proba of selection
      P=[ c0 c1 c2 c3 c4 c5]/(c0+c1+c2+c3+c4+c5)  %proba of selection for each mode
      %%
figure; 
 subplot(221),image(uint8(reconstactedIMG2(:,:,1))); title(['B=4 Q=30, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
 subplot(222),image(uint8(reconstactedIMG2(:,:,2))); title(['B=8 Q=30, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG2(:,:,3)));colormap(gray(256)); axis image; axis off; title(['B=16 Q=30, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); 
subplot(224),image(uint8(reconstactedIMG2(:,:,4)));colormap(gray(256)); axis image; axis off; title(['B=32 Q=30, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); 
 save dataIPPPdiffblksize

%%  all P but diff quant delta, same blk size, carfull some may take time  (bigger Quant step)
currentIMG= readFrame(videoFileName,10);
refImg = readFrame(videoFileName,1);

tic; [EncodedImgBitStream1,MotionVectsBitStream1,reconstactedIMG2(:,:,1), cost(1),mse(1),head1] = getFrameP(currentIMG,refImg,128,128,16,25);  tElapsed1 = toc;
tic; [EncodedImgBitStream2,MotionVectsBitStream2,reconstactedIMG2(:,:,2), cost(2),mse(2),head2] = getFrameP(currentIMG,refImg,128,128,16,50);  tElapsed2 = toc;    
tic; [EncodedImgBitStream3,MotionVectsBitStream3,reconstactedIMG2(:,:,3), cost(3),mse(3),head3] = getFrameP(currentIMG,refImg,128,128,16,75);  tElapsed3 = toc;
tic; [EncodedImgBitStream4,MotionVectsBitStream4,reconstactedIMG2(:,:,4), cost(4),mse(4),head4] = getFrameP(currentIMG,refImg,128,128,16,100); tElapsed4 = toc;    

psnr=10*log10(255^2./mse);

      time(1)=tElapsed1;
      time(2)=tElapsed2;
      time(3)=tElapsed3;
      time(4)=tElapsed4;
      % 
      s(1)=length(EncodedImgBitStream1)+length(MotionVectsBitStream1);
      s(2)=length(EncodedImgBitStream2)+length(MotionVectsBitStream2);
      s(3)=length(EncodedImgBitStream3)+length(MotionVectsBitStream3);
      s(4)=length(EncodedImgBitStream4)+length(MotionVectsBitStream4);
      %%
      c0=0;c1=0;c2=0;c3=0;c4=0;c5=0;   % change head3 to head1 --> head4 to find other probas , re-execute only this part 
      for i=1:size(head3,1)
          if head3(i,4)== 0, c0=c0+1; 			% mode none
          elseif head3(i,4)== 1, c1=c1+1;		% mode inter
          elseif head3(i,4)== 2, c2=c2+1;		% mode intra Vertical Replication
          elseif head3(i,4)== 3, c3=c3+1;		% mode intra Horizonatal 
          elseif head3(i,4)== 4, c4=c4+1;		% mode intra DC (mean mode)
          elseif head3(i,4)== 5, c5=c5+1;		% mode intra (min or max or a+b-c)
          end
      end
      %proba of selection
      P=[ c0 c1 c2 c3 c4 c5]/(c0+c1+c2+c3+c4+c5)  %proba of selection for each mode
      %%
figure; 
subplot(221),image(uint8(reconstactedIMG2(:,:,1))); title(['B=16 Q=25, PSNR=' num2str(psnr(1)) ', cost=' num2str(cost(1)) ', CompuTime=' num2str(time(1)) 's, size=' num2str(s(1))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(222),image(uint8(reconstactedIMG2(:,:,2))); title(['B=16 Q=50, PSNR=' num2str(psnr(2)) ', cost=' num2str(cost(2)) ', CompuTime=' num2str(time(2)) 's, size=' num2str(s(2))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); colormap(gray(256)); axis image; axis off;
subplot(223),image(uint8(reconstactedIMG2(:,:,3))); colormap(gray(256)); axis image; axis off; title(['B=16 Q=75, PSNR=' num2str(psnr(3)) ', cost=' num2str(cost(3)) ', CompuTime=' num2str(time(3)) 's, size=' num2str(s(3))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); 
subplot(224),image(uint8(reconstactedIMG2(:,:,4))); colormap(gray(256)); axis image; axis off; title(['B=16 Q=100, PSNR=' num2str(psnr(4)) ', cost=' num2str(cost(4)) ', CompuTime=' num2str(time(4)) 's, size=' num2str(s(4))  'Bytes, mode: P'],'LineWidth',1.8,'LineStyle','-.'); 

%%  what happens when lambda changes??!!!
% one P , same blk size and quant, carfull some may take time (bigger lmbda)
% please go inside ;
% inter line : 71 
% intra line: 46
% NonePrediction line : 10
% change lamda  and execute each time : lamnda 0.2 0.4 0.6 0.8
% enregistrer : proba ,psnr, size , time for each lambda

currentIMG= readFrame(videoFileName,10);
refImg = readFrame(videoFileName,1);

tic; [EncodedImgBitStream1,MotionVectsBitStream1,reconstactedIMG2(:,:,1), cost(1),mse(1),head1] = getFrameP(currentIMG,refImg,128,128,16,25);  tElapsed1 = toc;
psnr=10*log10(255^2./mse);
time(1)=tElapsed1;
s(1)=length(EncodedImgBitStream1)+length(MotionVectsBitStream1);

      %%
      c0=0;c1=0;c2=0;c3=0;c4=0;c5=0;   % change head3 to head1 --> head4 to find other probas , re-execute only this part 
      for i=1:size(head1,1)
          if head1(i,4)== 0, c0=c0+1; 			% mode none
          elseif head1(i,4)== 1, c1=c1+1;		% mode inter
          elseif head1(i,4)== 2, c2=c2+1;		% mode intra Vertical Replication
          elseif head1(i,4)== 3, c3=c3+1;		% mode intra Horizonatal 
          elseif head1(i,4)== 4, c4=c4+1;		% mode intra DC (mean mode)
          elseif head1(i,4)== 5, c5=c5+1;		% mode intra (min or max or a+b-c)
          end
      end
      %proba of selection
      P=[ c0 c1 c2 c3 c4 c5]/(c0+c1+c2+c3+c4+c5)  %proba of selection for each mode