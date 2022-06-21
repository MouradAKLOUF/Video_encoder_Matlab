function [codes, SIZE ]=fullRLEforMVF(matrix,blck,mode)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   coding of Motion vectors : this function do not do the RLE only but 3
%   types , the name is bad
% 
%   inputs : matrix= MV,
%       blck= blk size , but =1 if you put MV per block and not per pixel
%       mode= 0,1 or 2 for FLE , Psedo Huffman or HEVC like encoding
% 
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialize Variables
[H, W, Z]=size(matrix); 
codes=[];
if mode==0 % Fixed L E
    for i=1:blck:H
        for j=1:blck:W
            zone=matrix(i:i+blck-1,j:j+blck-1,:);
            [cc, SIZE ]= smallRLEforMVF(zone,0);
            codes= cat(2,codes,cc);
        end
    end
elseif mode==1 % Variable L E
    for i=1:blck:H
        for j=1:blck:W
            zone=matrix(i:i+blck-1,j:j+blck-1,:);
            [cc, SIZE ]= smallRLEforMVF(zone,1);
            codes= cat(2,codes,cc);
        end
    end
elseif mode==2 % HEVC like Encoding
    for i=1:blck:H
        for j=1:blck:W
            zone=matrix(i:i+blck-1,j:j+blck-1,:);
            if i==1 && j==1 , diff(i:i+blck-1,j:j+blck-1,:)=zone;
            elseif i==1, diff(i:i+blck-1,j:j+blck-1,:)=zone-matrix(i:i+blck-1,j-blck:j-1,:);
            elseif j==1, diff(i:i+blck-1,j:j+blck-1,:)=zone-matrix(i-blck:i-1,j:j+blck-1,:);
            else
                zone1=matrix(i-blck:i-1,j:j+blck-1,:);
                zone2=matrix(i:i+blck-1,j-blck:j-1,:);
                zone3=matrix(i-blck:i-1,j-blck:j-1,:);
                for z=1:Z
                    for k=1:blck
                        for l=1:blck
                            DIFF(k,l,z) = zone(k,l,z)- median([zone1(k,l,z) zone2(k,l,z) zone3(k,l,z)]);
                        end
                    end
                end
                diff(i:i+blck-1,j:j+blck-1,:)= IPCM(:,:,:);
                
            end
            
            for i=1:blck:H
                for j=1:blck:W
                    zone=diff(i:i+blck-1,j:j+blck-1,:);
                    [cc, SIZE ]= smallRLEforMVF(zone,1);
                    codes= cat(2,codes,cc);
                end
            end
            
        end
    end   
end

% Final Marker
codes(end+1)=255;
codes(end+2)=255;
SIZE=SIZE+2;
end
%%