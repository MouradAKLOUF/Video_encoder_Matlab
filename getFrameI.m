function [stream1, reconst, COST, MSE, head] = getFrameI(img,Blk,delta,mode)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   get the I slice : make intra or noprediction for each blk in the img
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @Telecom ParisTech 03/2018
%
%  inputs : 
%         img(matrix)= current img to code
%         Blk(int)= blk size
%         delta(int)= Quant step
%         mode(char) = 'none' or 'intra'
%
%  outputs : 
%         stream1(array) = stream of coded indx 
%         reconst(matrix) = decoded img
%         COST(double) = avrg cost of a blk in this sliece
%         MSE(double) = avrg mse of a blk in this sliece
%         head(matrix K*4) = signalisation matrix= [XpositionOFtheBlk YpositionOFtheBlk BlkSize Mode(0 none or 2,3,4 intra]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ROWS, COLS] =size(img);
reconst=zeros(ROWS, COLS,'double');
COST=0;
MSE=0;
head=zeros((ROWS*COLS)/(Blk*Blk),4,'int8');
stream1=[];
prevDecodedImg=zeros(ROWS+1,COLS+1);
%%%%%%%
    lastDC=128;
    h=1;
    for i=1:Blk:ROWS
        for j=1:Blk:COLS
            pos1 = ceil(i/Blk); pos2 = ceil(j/Blk);
            zone=(img(i:i+Blk-1,j:j+Blk-1));
            if strcmp(mode,'intra')
                if i==1 && j==1 ,[reconstBlock,stream,cost,mse,newDC]= NoPrediction(zone,Blk,delta,lastDC); intraMode=0; 
                else [reconstBlock,stream,intraMode,cost,mse,newDC]=intra(zone,prevDecodedImg,i+1,j+1,Blk,delta,lastDC);
                end
            elseif strcmp(mode,'none')
            [reconstBlock,stream,cost,mse,newDC]= NoPrediction(zone,Blk,delta,lastDC);  
            intraMode=0;
            end
            lastDC=newDC;
            COST=COST+cost;
            MSE=MSE+mse;
            head(h,:)=[pos1 pos2 Blk intraMode]; h=h+1;
            reconst(i:i+Blk-1,j:j+Blk-1)=reconstBlock;
            stream1=[stream1 stream];
            prevDecodedImg(2:ROWS+1,2:COLS+1)= reconst;
        end
    end
%%%%%%%
MSE=MSE/(h-1);
COST=COST/(h-1);
end

