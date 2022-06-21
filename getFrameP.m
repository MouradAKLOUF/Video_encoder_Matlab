function [stream1,stream2,reconst,COST,MSE,head] = getFrameP(img,refImg,search1,search2,Blk,Q_delta)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   get the P slice : make intra ,inter or noprediction for each blk in the img
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @Telecom ParisTech 03/2018
%
%  inputs : 
%         img(matrix)= current img to code
%         refImg(matrix)= reffrence img for inter predi
%         Blk(int)= blk size
%         Q_delta(int)= Quant step
%         mode(char) = 'none' or 'intra'
%         search1,search2 (int) = search wind Horiz*Vertical
%
%  outputs : 
%         stream1(array) = stream of coded indx 
%         stream2(array) = stream of coded Motion vects 
%         reconst(matrix) = decoded img
%         COST(double) = avrg cost of a blk in this sliece
%         MSE(double) = avrg mse of a blk in this sliece
%         head(matrix K*4) = signalisation matrix= [XpositionOFtheBlk YpositionOFtheBlk BlkSize Mode(0 none , 1 inter , or 2,3,4 intra) ]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ROWS, COLS] =size(img);
reconst=zeros(ROWS, COLS,'double');
mvfMatrix=zeros(ROWS/Blk, COLS/Blk);
head=zeros((ROWS*COLS)/(Blk*Blk),4,'int8');
COST=0;
MSE=0;
stream1=[];
prevDecodedImg=zeros(ROWS+1,COLS+1);
%%%%%%%
    lastDC=128;
    h=1;
    for i=1:Blk:ROWS
        for j=1:Blk:COLS
            pos1 = ceil(i/Blk); pos2 = ceil(j/Blk);
            zone=(img(i:i+Blk-1,j:j+Blk-1));
            [reconstBlock,MVFvector,bitStream,Mode,cost,mse,lastDC]= BestModeSelector(zone,i,j,prevDecodedImg,refImg,search1,search2,Blk,Q_delta,lastDC);
            COST=COST+cost;
            MSE=MSE+mse;
            head(h,:)=[pos1 pos2 Blk Mode]; h=h+1;
            reconst(i:i+Blk-1,j:j+Blk-1)=reconstBlock;
            mvfMatrix(pos1,pos2,1)=MVFvector(1,1); mvfMatrix(pos1,pos2,2)=MVFvector(1,2);
            stream1= [stream1 bitStream];
            prevDecodedImg(2:ROWS+1,2:COLS+1)= reconst;
            COST=COST+cost;
            MSE=MSE+mse;
        end
    end
%%%%%%%
MSE=MSE/(h-1);
COST=COST/(h-1);
[stream2,~]=fullRLEforMVF(mvfMatrix,1,1);
end

