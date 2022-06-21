function [codes, SIZE ]= smallRLEforMVF(matrix,mode)

% Initialize Variables
outt1=zigZagScan(matrix(:,:,1));
outt2=zigZagScan(matrix(:,:,2));
if mode==0 % Fixed LE
    codes=[outt1 outt2];
    SIZE=length(codes);
elseif mode==1 % Variable LE
    % Huffman Compression
    vect1 = outt1(1:end);
    vect2 = outt2(1:end);
    stream=cat(2,MVhuffmanCoding(vect1),MVhuffmanCoding(vect2));
    %Convert String To Decimal
    Bytes=floor(length(stream)/8);
    rest=length(stream)-Bytes*8;
    s=1;
    
    if rest~=0, codes=zeros(1, Bytes+1,'int8');
    else codes=zeros(1, Bytes,'int8'); end

    for i=1:8:Bytes*8
        codes(s)=bin2dec(stream(1,i:i+7));
        s=s+1;
    end
    if rest~=0
        s=s+1;
        codes(s)=bin2dec(stream(1,Bytes*8+1:length(stream)));
    end
    SIZE=s;
end
end

%%