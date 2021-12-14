function [AA,JA,IA]= myCSR(A)
    col = size(A,2);
    lig = size(A,1);
    AA = list();
    JA = list();

    IA($+1) = 1;
    for i = 1:lig
        cpt = 0;
        for j = 1:col

            if A(i,j) ~= 0
                AA($+1) = A(i,j);
                JA($+1) = j;
                cpt = cpt + 1;
            end

        end
        IA($+1) = IA($) + cpt;
    end

endfunction
