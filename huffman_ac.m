
function code = huffman_ac(vector)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   get pseudo huffman code of the AC coeff : vect is AC coeffafter zigzagscan 
%
%   MN910 – Advanced Compression , Master 2 research Multimedia Networking 
%   Mourad AKLOUF & Maroua BAKOUR @ Telecom paristech 03/2018
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C=[];
EOB = '1111'; %final marker
huffman_table = {'0', '10','110', '1110','11110', '111110', '1111110', '11111110', '111111110', '1111111110'};

container=[];
zeros=0;
k=1;

for i=1:length(vector)
    if vector(i)~=0
        container(1,k)= vector(i);
        container(2,k)= zeros;
        zeros=0;
        k=k+1;
    else 
        zeros=zeros+1;
    end
end
 

for k=1:size(container,2)

%c=dec2bin(abs(container(1,k)));
d=floor(container(1,k)/14);
rest2=container(1,k)-d*14;
c=[];
for i=1:d, c=[c '00001110']; end
e=dec2bin(rest2);
for i=size(e,2):4-1, e=['0' e]; end
c=[c e];

%%
a=floor(abs(container(2,k))/15);
rest=container(2,k)-a*15;
z=[];
        
for i=1:a, z=[ z '1111']; end
b=dec2bin(rest);
for i=size(b,2):4-1, b=['0' b]; end
z=[z b];
    
    if container(1,k)> 0
    temp = [z huffman_table{size(dec2bin(abs(container(1,k))),2)+1} c];
    C=[C temp];
    else
        for i=1:size(c,2)
            if c(:,i)=='0'
                c(:,i)='1';
            else
                c(:,i)='0';
            end
        end
        temp = [z huffman_table{size(dec2bin(abs(container(1,k))),2)+1} c];
        C=[C temp];
    end
end
code = [C EOB];

end
