exec ./CSR.sci
exec ./matvecCSR.sci

taille = 3100;
iter = 20;

[fic,mod] = mopen("matvecCSR.dat" , "w");

for t = 100 : 500 : taille
    err = 0;

    disp(string(t)+"/"+string(taille));
    for i = 1 : iter

        A = sprand(t, t, 0.25);
        A = full(A);
        v = ones(t,1);

        [AA,JA,IA] = myCSR(A);
        v2 = matvecCSR(AA,JA,IA,v,t);
        
        err = err + norm(v2 - (A*v));
    end

     mfprintf(fic, "%.17lf %d\n", err/iter, t);

end

mclose(fic);
