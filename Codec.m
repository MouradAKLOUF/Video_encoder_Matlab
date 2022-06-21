function [bitRate,avrgPSNR] = Codec(videoFileName,GOPtype,QuantStep,GOPsize,nbrGOPsForTest,IframeMode,intraBlockSize,interBlockSize,searchWind1,searchWind2,savedVideoFileName)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This is the main function for the project : video encoder 
%	encode the Y copenent of a yuv vedio in 2 diff GOP types , and 3 modes of prediction ( inter ,intra ,noPrediction)
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @Telecom ParisTech 03/2018
% 
%  example : (minimal inputs)
%  [bitRate,avrgPSNR] = Codec02('foreman_cif.y', 'IIII' , [30  70  120] );
%  example 2 :
%  [bitRate,avrgPSNR] = Codec02('foreman_cif.y','IIII',[45],4,5,'none',16,16,128,128,'myCompressedVideo.bin')
%
%  inputs : 
%     videoFileName(char) 
%     GOPtype(char) : 'IIII' or 'IPPP'
%     QuantStep (This is an array)
%     GOPsize(int) : nbr of frames in one GOP ; default =4
%     nbrGOPsForTest(int) : how many GOPs u want to code ? , an option for not waisting time ; default =5
%     IframeMode(char) : do u want an 'none' or 'intra' mode prediction in the I frames ? default 'none'
%     intraBlockSize(int) : block size in intra and noprediction mode; default =16
%     interBlockSize(int) : block size in inter mode; default =16
%     searchWind1,searchWind2(int) : search wind for inter mode (horiz & vertic); default = 128*128
%     savedVideoFileName(char) : output file name ,wich contains the coded imgs; default = 'myCompressedVideo.bin'
%     ********** look at Section "inputs" for other default parameters you may change
%
%  outputs : 
%     myCompressedVideo.bin(char)= coded imgs saved in this file, u may change the name at line 58;
%     ploting of RD if QuantStep=array, else print bitRate(1) avrgPSNR(1) when dim(QuantStep)=1*1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  inputs 

if (nargin < 4)   

% clc, clear, close all;
% videoFileName = 'foreman_cif.y';
% videoFileName='akiyo_cif.yuv';

% GOPtype='IIII';               % 'IIII' or 'IPPP', go to line 90 to change the mode of the 1st frame in case IPPP
IframeMode='none';
GOPsize=4;

%Quant parameters
% QuantStep=[10  30  70  120  180  200];  

%block size
intraBlockSize=16;
interBlockSize=16;
searchWind1 =128;  %search wind for inter mode (horiz & vertic)
searchWind2 =128;

nbrGOPsForTest=5;  %how many GOPs u want to test , use small nbr for small comput time

savedVideoFileName='myCompressedVideo.bin';  %output file name
       
end


%% 
delete(savedVideoFileName); %delete if exists

[rows,cols]= size(readFrame(videoFileName,10));  %size of 1 frame 
videoSize=GetVideoSize(videoFileName,'y'); %nbr of frames in the vedio
nbrOfGOPs=floor(videoSize/GOPsize);
nbrRestFrames=videoSize-nbrOfGOPs*GOPsize;

%% memory pre-allocate for speed 
currentIMG=zeros(rows,cols,nbrGOPsForTest*GOPsize,'double');
reconstactedIMG=zeros(rows,cols,nbrGOPsForTest*GOPsize,'double');
%reconstactedIMG2=zeros(rows,cols,nbrGOPsForTest*4,'double');
cost=zeros(1,nbrGOPsForTest*GOPsize,'double');
mse=zeros(1,nbrGOPsForTest*GOPsize,'double');

%%

for ii=1:length(QuantStep)
    
delete(savedVideoFileName);         %delete  output file betwen 2 QuantSteps
    
delta0=QuantStep(ii); %for None
delta1=QuantStep(ii); %for intra
delta2=QuantStep(ii); %for inter

tic;  

l=1;
for indx=1:nbrGOPsForTest %nbrOfGOPs  
    
ImgsInGOP= readGOP(videoFileName,GOPsize,indx-1,'y');

if strcmp(GOPtype,'IIII')
    
      for k=1:GOPsize  
      currentIMG(:,:,l) = ImgsInGOP(:,:,k);
      [EncodedImgBitStream, reconstactedIMG(:,:,l), cost(l),mse(l),head] = getFrameI(currentIMG(:,:,l),intraBlockSize,delta1,IframeMode);  % change 'intra' to 'none' if u want to
      HEAD=head'; writeInfile(HEAD(:),savedVideoFileName);
      writeInfile(EncodedImgBitStream,savedVideoFileName);
      l=l+1;
      end
      
elseif strcmp(GOPtype,'IPPP')
    
      currentIMG(:,:,l) = ImgsInGOP(:,:,1);
      [EncodedImgBitStream, reconstactedIMG(:,:,l), cost(l),mse(l),head] = getFrameI(currentIMG(:,:,l),intraBlockSize,delta1,IframeMode);% change 'intra' to 'none' if u want to
      HEAD=head'; writeInfile(HEAD(:),savedVideoFileName);
      writeInfile(EncodedImgBitStream,savedVideoFileName);
      refImg = reconstactedIMG(:,:,l);
      l=l+1;
      
    for k=2:GOPsize
       
      currentIMG(:,:,l) = ImgsInGOP(:,:,k);
      [EncodedImgBitStream,MotionVectsBitStream,reconstactedIMG(:,:,l), cost(l),mse(l),head] = getFrameP(currentIMG(:,:,l),refImg,searchWind1,searchWind2,interBlockSize,QuantStep(ii));
      refImg = reconstactedIMG(:,:,l);
      HEAD=head'; writeInfile(HEAD(:),savedVideoFileName);
      writeInfile(EncodedImgBitStream,savedVideoFileName);
      writeInfile(MotionVectsBitStream,savedVideoFileName);
      l=l+1;
      
    end
end

end

tElapsed(ii) = toc;
out = dir(savedVideoFileName);
SizE(ii)=(out.bytes)*8 ;            %Bits
bitRate(ii)=SizE(ii)/(l*rows*cols) ;     %Bits per pixel
psnr=10*log10(255^2./mse);
avrgPSNR(ii)=mean(psnr)  ;      %avrg PSNR
avrgCOST(ii)=mean(cost)  ;      %avrg Cost

% figure; plot(psnr,'*r'); title('psnr vs frame indx'); axis([0 50 20 45]); ylabel('psnr');xlabel('frame indx'); 

end
%%

figure;
plot(bitRate,avrgPSNR,'-xr'); title('RD curve'); ylabel('PSNR dB');xlabel('Bit Rate bpp');


%%

figure; % play the video : last Quantstep only
for i=1:1:nbrGOPsForTest*GOPsize
subplot(121),image(uint8(currentIMG(:,:,i))); title('original'); colormap(gray(256)); axis image; axis off;
subplot(122),image(uint8(reconstactedIMG(:,:,i))); title('coded img'); colormap(gray(256)); axis image; axis off;
pause(0.04) % in seconds 
end

%  save ThisData
%  load ThisData
%  clear all

end