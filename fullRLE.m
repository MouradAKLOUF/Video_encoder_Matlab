function [codes, SIZE ]=fullRLE(matrix,blck)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   make a RLE by blocks in one image : never used in the main code
% 
%   inputs : matrix= img , blck= block size in wich u did the dct+quantz
% 
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize Variables

[H, W]=size(matrix); 
nbrBLCKrow=floor(H/blck);
nbrBLCKcol=floor(W/blck);
zigZag_AC = zeros(nbrBLCKcol*nbrBLCKrow, blck*blck-1);
zigZag_DC = zeros(nbrBLCKcol*nbrBLCKrow, 1);

%% Segmenting Image Blocks Of 8x8
k=1;
for i=1:blck:H
    for j=1:blck:W
        zone=(img(i:i+blck-1,j:j+blck-1));
        out=zigZagScan(zone);
        zigZag_DC(k,1) = out(1);
        zigZag_AC(k,1:63) = out(2:end);
        k=k+1;
    end
end

%% Huffman Compression
stream=[];
dpcm(1,1)=128-zigZag_DC(1,1);
stream=cat(2,stream,huffman_dc(dpcm(1,1)),huffman_ac(zigZag_AC(1,1:63)));

for m=2:nbrBLCKrow*nbrBLCKcol
    dpcm(m,1)=zigZag_DC(m-1,1)-zigZag_DC(m,1);
    stream=cat(2,stream,huffman_dc(dpcm(m,1)),huffman_ac(zigZag_AC(m,1:63)));
end

%% Convert String To Decimal

Bytes=floor(length(stream)/8);
rest=length(stream)-numbytes*8;
s=1;

if rest~=0, codes=zeros(1, Bytes+1,'int8');
else codes=zeros(1, Bytes,'int8'); end

for count2=1:8:Bytes*8
    codes(s)=bin2dec(stream(1,count2:count2+7));
    s=s+1;
end
if rest~=0
    s=s+1;
    codes(s)=bin2dec(stream(1,numbytes*8+1:length(stream)));
end
    
%% Final Marker
codes(s+1)=255;
codes(s+2)=255;
SIZE=s+2;

end
%%