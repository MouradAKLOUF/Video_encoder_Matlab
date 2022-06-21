function [reconstBlock,mvfVector,bitStream1,cost,mse,newDC]=inter(currentblock,ref,ii,jj,block,search1,search2,delta,lastDC)

% ME
[rows, cols]=size(ref);
B=currentblock; 
brow=block; bcol=block;
r=ii; c=jj;   
dcolmin=0; drowmin=0; 
SSDmin=brow*bcol*256*256; 

        for dcol=-search1:search1,  
            for drow=-search2:search2,
                if ((r+drow>0)&&(r+drow+brow-1<=rows)&&(c+dcol>0)&&(c+dcol+bcol-1<=cols))
                    R=ref(r+drow:r+drow+brow-1, c+dcol:c+dcol+bcol-1); 
                    SSD=sum(sum((B-R).*(B-R)));                 
                    if (SSD<SSDmin) 
                        SSDmin=SSD;
                        dcolmin=dcol;
                        drowmin=drow;
                    end;
                end; % 
            end; % 
        end; 
mvf(1:brow,1:bcol,1)=drowmin;
mvf(1:brow,1:bcol,2)=dcolmin;

mvfVector(1,1)=drowmin;
mvfVector(1,2)=dcolmin;

size2 = size([MVhuffmanCoding(drowmin) MVhuffmanCoding(dcolmin)],2);
size2=ceil(size2/8);

%MC
motCompImg=zeros(brow,bcol);
for r=0:block-1,
    for c=0:block-1,
        mc_r = r+ii + floor(mvf(r+1,c+1,1));
        mc_c = c+jj + floor(mvf(r+1,c+1,2));
        if(mc_r <1 ), mc_r=1;
        elseif (mc_r > rows ) , mc_r=rows; end
        if(mc_c < 1), mc_c=1;
        elseif(mc_c > cols ) , mc_c=cols ; end
        motCompImg(r+1,c+1)=ref(mc_r,mc_c);
    end
end 
Resid=currentblock-motCompImg;
%
dct2img = blkproc(Resid,[block block], @dct2);
Qind = (fix(dct2img/delta));   % indice de quant QU_DZ Dead-zone uniform quantization
Quantimg = delta.*Qind  + (Qind~=0).*sign(dct2img).*delta/2; %% Decoder
Resid_hat = blkproc(Quantimg,[block block],@idct2);
%
reconstBlock = motCompImg+Resid_hat;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mse=sum(sum((currentblock-reconstBlock).^2))/(block*block);
    [bitStream1, size1, dc]= smallRLE(Qind,lastDC);
    cost= mse+0.5*(size1+size2);
    newDC=dc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
