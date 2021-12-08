function [v2]= matvecCSC(AA,JA,IA,v,lig)
    v2 = zeros(1,lig);
    for i = 1 : lig
        total = 0;
        for j = 1 : length(JA)
            if JA(j) == i
                for k = 1 : length(IA)
                    if j >= IA(k) & j < IA(k+1)
                        total = total + AA(j) * v(k)
                    end
                end
            end
        end
        v2(i) = total;
    end
endfunction
