%
function code = huffman_dc(dc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   get pseudo huffman code of a dc coeff : dc here is a diff ; sigma=dc(i-1)-d(i) 
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

huffman_table = {'0', '10','110', '1110','11110', '111110', '1111110', '11111110', '111111110', '1111111110'};

if dc==0, temp='0';
elseif dc>0
    temp = [huffman_table{size(dec2bin(dc),2)+1} dec2bin(dc)]; 
else
    c=dec2bin(abs(dc));
    for i=1:size(c,2)
        if c(:,i)=='0'
            c(:,i)='1';
        else
            c(:,i)='0';
        end
    end
    temp = [huffman_table{size(c,2)+1} c];
end

code=temp;

end
