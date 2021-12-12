function [v2]= matvecCSR(AA,JA,IA,v,col)

cpt = 1;
v2 = zeros(col,1);

for i = 1 : col;

    for j = 1 : IA(i+1)-IA(i)

        v2(i) = v2(i) + AA(cpt) * v(j);
        cpt = cpt + 1; 

    end

end
endfunction
