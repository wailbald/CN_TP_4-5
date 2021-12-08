function [AA, JA, IA] = myCSC(A)
    col = size(A,2);
    lig = size(A,1);
    AA = list();
    JA = list();
    IA = list();

    IA($+1) = 1;
    for i = 1 : col
        val = 0

        for j = 1 : lig
            
            if A(j,i) ~= 0
                AA($+1) = A(j,i);
                JA($+1) = j;
                val = val + 1;
            end

        end
        IA($+1) = IA($) + val;
    end

endfunction
