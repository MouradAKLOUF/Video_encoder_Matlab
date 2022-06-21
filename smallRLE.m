function [codes, SIZE, dc ]= smallRLE(matrix,lastDC)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 	Doing REL for one small blck
%
%   inputs : matrix= blk to encode 
%	lastDC= prevous dc coeff
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize Variables
outt=zigZagScan(matrix);
AC = outt(2:end);
DC = lastDC-outt(1);
dc= outt(1);

%% Huffman Compression
stream=[];
stream=cat(2,stream,huffman_dc(DC),huffman_ac(AC));
%% Convert String To Decimal

Bytes=floor(length(stream)/8);
rest=length(stream)-Bytes*8;

if rest~=0, codes=zeros(1, Bytes+1,'int8');
else codes=zeros(1, Bytes,'int8'); end

s=1;
for i=1:8:Bytes*8
    codes(s)=bin2dec(stream(1,i:i+7));
    s=s+1;
end
SIZE=Bytes;
if rest~=0
    s=s+1;
    codes(s)=bin2dec(stream(1,Bytes*8+1:length(stream)));
    SIZE=SIZE+1;
end
end
%%