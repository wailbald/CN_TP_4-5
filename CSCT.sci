function [AAT, JAT, IAT] = myCSCT(AA, JA, IA, lig, col)

    AAT = list(); 
    JAT = list();
    IAT = list();
    IAT($+1) = 1;
    nb = 0;

    for i = 1 : lig
        val = 0;

        for j = 1 : length(AA)

            if JA(j) == i

                AAT($+1) = AA(j);
                nb = nb + 1;
                val = val + 1;

                for k = 1 : length(IA) -1
                    if j >= IA(k) & j <= IA(k+1)
                        JAT(nb) = k;
                    end
                end

            end

        end

        IAT($+1) = IAT($) + val;
    end

endfunction
