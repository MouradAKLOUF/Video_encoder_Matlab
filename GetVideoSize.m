function SIZE= GetVideoSize(fileName,type)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   get nbr of frames in video : works with cif vedios only
%
% inputs:
%     fileName(char)
%     type = 'y' or 'yuv'
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    format = struct('resolution','cif','color','420','output','y');
    k=1;
    
    while true
    try
       if strcmp(type,'y'), img= readFrame(fileName,k);
       elseif strcmp(type,'yuv'), img= readFrame(fileName,format,k);
       end
       k=k+1;
    catch ME
       SIZE=k-1;
       break;
    end 
    end
    
end




