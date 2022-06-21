
function [reconstBlock,bitStream,intraMode,cost,mse,newDC]=intra(zone,replica,ii,jj,Blk,delta,lastDC)

line=zeros(1,Blk,'double');
column=zeros(1,Blk,'double');

  for k=0:Blk-1
        line(k+1)=replica(ii-1,jj+k); % TOP pixels above the block
        column(k+1)=replica(ii+k,jj-1); % LEFT pixels before the block
  end
  pix00=replica(ii-1,jj-1); 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % Call Different Mode Functions for N=8 or N=16
     out0=mode0(line,Blk);         %Vertical Replication
     out1=mode1(column,Blk);         %Horizonatal Replication
     out2=mode2(column,line,Blk);       % DC
 
     % Compute SAD for All images from different modes
     SAD(1)=sum(sum(abs(out0-zone)));
     SAD(2)=sum(sum(abs(out1-zone)));
     SAD(3)=sum(sum(abs(out2-zone)));
     % Selection based on min SAD
     [~,minSAD]=min(SAD);
     switch minSAD
        case 1
            predictBlock=out0;
            intraMode=0;
        case 2
            predictBlock=out1;
            intraMode=1;
        case 3
            predictBlock=out2;
            intraMode=2;
     end
     intraMode=intraMode+2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Resid=zone-predictBlock;
    dct = blkproc(ceil(Resid),[Blk Blk], @dct2);
    Qind = (fix(dct/delta));   % indice de quant QU_DZ Dead-zone uniform quantization
    invQind = delta.*Qind  + (Qind~=0).*sign(dct).*delta/2; %% Decoder
    Resid_hat = blkproc(invQind,[Blk Blk],@idct2);
    reconstBlock = predictBlock+Resid_hat;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mse=(sum(sum((zone-reconstBlock).^2)))/(Blk*Blk);
    [bitStream, SizE, dc ]= smallRLE(Qind,lastDC);
    cost= mse+0.5*SizE;
    newDC=dc;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  end
  
%%
function out=mode0(line,BLK)
out=zeros(BLK,BLK,'double');
    for i=1:BLK
       for j=1:BLK
            out(i,j)=line(j); % Vertical Replication
        end
    end
end

function out=mode1(column,BLK)
out=zeros(BLK,BLK,'double');
    for i=1:BLK
        for j=1:BLK
           out(i,j)=column(i);  % Horizonatal Replication
        end
    end
end


function out=mode2(column,line,BLK)
out=zeros(BLK,BLK,'double');
    for i=1:BLK
        for j=1:BLK
            out(i,j)=round(mean([column(1:BLK) line(1:BLK)]));  % DC
        end
    end
end








