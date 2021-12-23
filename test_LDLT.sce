exec ./LDLT.sci
exec ./mylu1b.sci
exec ./mylu3b.sci

taille = 310;
iter = 10;
[fic, mod] = mopen("LDLT.dat", "w");

for t = 10 : 50 : taille
    temps = 0;
    tempslu = 0;
    temps1b = 0;
    temps3b = 0;
    err = 0;
    errlu = 0;

    disp(string(t)+"/"+string(taille))
    for i = 1 : iter

        A = rand(t,t) + ones(t,t);
        B = tril(A);
        A = B * B';
        AA = A;

        tic();
        A = LDLT(A);
        temps = temps + toc();

        tic();
        [LL,UU] = lu(AA);
        tempslu = tempslu + toc();

        tic();
        [L1b,U1b] = mylu1b(AA);
        temps1b = temps1b + toc();

        tic();
        [L3b,U3b] = mylu3b(AA);
        temps3b = temps3b + toc();

        L = tril(A);

        for k = 1 : t
            L(k,k) = 1;
        end

        D = diag(A);
        DD = zeros(t,t);

        for k = 1 : t
            DD(k,k) = D(k);
        end

        err = norm(AA - L*DD*L')/norm(AA);
    end
    mfprintf(fic, "%.17lf %.17lf %.17lf %.17lf %.17lf %d\n", err/iter, temps/iter, tempslu/iter, temps1b/iter, temps3b/iter, t);
end
mclose(fic);
