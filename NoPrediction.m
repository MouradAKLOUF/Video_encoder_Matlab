function [reconst,bitStream,cost,mse,newDC]= NoPrediction(currentblock,block,delta,lastDC)

dct = blkproc(currentblock,[block block], @dct2);
Qind = (fix(dct/delta));   % indice de quant QU_DZ Dead-zone uniform quantization
invQuant = delta.*Qind  + (Qind~=0).*sign(dct).*delta/2; %% Decoder
reconst = blkproc(invQuant,[block block],@idct2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mse=sum(sum((currentblock-reconst).^2))/(block*block);
    [bitStream, Size, dc]= smallRLE(Qind,lastDC);
    cost= mse+0.5*Size;
    newDC=dc;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end