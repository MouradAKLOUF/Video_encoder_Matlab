function imgInGOP= readGOP(fileName, GOPsize,indx,type)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   read one GOP of size 'GOPsize' and  position 'indx' , 
%     	type = 'y' or 'yuv'

%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    imgInGOP=zeros(288,352,4,'double');
    format = struct('resolution','cif','color','420','output','y');
    l=1;
    for k=(indx*GOPsize)+1:(indx*GOPsize)+GOPsize
        
        if strcmp(type,'y'), imgInGOP(:,:,l) = readFrame(fileName,k);
        elseif strcmp(type,'yuv'), imgInGOP(:,:,l) = readFrame(fileName,format,k);
        end
        l=l+1;
        
    end

end