function [reconst,MotionVects,bitStream,Mode,COST,MSE,newDCcoeff]= BestModeSelector(currentblock,ii,jj,prevDecodedImg,refImg,search1,search2,block,QuantStep,lastDCcoeff)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   select best mode for p frames :

% inputs:
% 	currentblock = block of size **block**
% 	ii,jj = block posution
% 	prevDecodedImg = prevous decoded block for intra
% 	refImg = reff img for inter
% 	search1,search2= serch window for inter
% 	block= block size (dim=1)
% 	QuantStep
% 	lastDCcoeff= DC coeff of prevous block

%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delta0=QuantStep; %for None
delta1=QuantStep; %for intra
delta2=QuantStep; %for inter
        
j=zeros(1,3,'double'); %cost vect for the 3 prediction modes

if  ii==1 && jj==1 ,
    
    [reconst1,bitStream1,j(1),mse(1),newDC(1)]= NoPrediction(currentblock,block,delta0,lastDCcoeff);

    [reconst2,MotionVects,bitStream2,j(2),mse(2),newDC(2)]=inter(currentblock,refImg,ii,jj,block,search1,search2,delta2,lastDCcoeff);

    j(3)=inf;

else
    
    [reconst1,bitStream1,j(1),mse(1),newDC(1)]= NoPrediction(currentblock,block,delta0,lastDCcoeff);

    [reconst2,MotionVects,bitStream2,j(2),mse(2),newDC(2)]=inter(currentblock,refImg,ii,jj,block,search1,search2,delta2,lastDCcoeff);

    [reconst3,bitStream3,intraMode,j(3),mse(3),newDC(3)]=intra(currentblock,prevDecodedImg,ii+1,jj+1,block,delta1,lastDCcoeff);

end
        
[~,mode] = min(j); % 1= none , inter=2 , intra=3

if mode==1
    reconst=reconst1;
    MotionVects(1,1)=0;MotionVects(1,2)=0;  % put MV (0,0) in case no inter predic
    bitStream=bitStream1;
    Mode=0;
    COST=j(1);
    MSE=mse(1);
    newDCcoeff=newDC(1);
elseif mode==2
    reconst=reconst2;
    MotionVects= MotionVects;
    bitStream=bitStream2;
    Mode=1;
    COST=j(2);
    MSE=mse(2);
    newDCcoeff=newDC(2);
elseif mode==3
    reconst=reconst3;
    MotionVects(1,1)=0;MotionVects(1,2)=0;
    bitStream=bitStream3;
    Mode=intraMode;
    COST=j(3);
    MSE=mse(3);
    newDCcoeff=newDC(3);
end

end

