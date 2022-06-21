function code = MVhuffmanCoding(vect)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% psudo huffman coding for motion vectors 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
code=[];

if length(vect)== 1
    code=huffman_dc(vect);
else
    for i=1:length(vect)
        code=[code huffman_dc(vect(i))];
    end
end

end
