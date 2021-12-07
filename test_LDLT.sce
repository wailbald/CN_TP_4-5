exec ./LDLT.sci

taille = 1010;
iter = 20;
[fic, mod] = mopen("LDLT.dat", "w");

for t = 10 : 100 : taille
    temps = 0;
    tempslu = 0;
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

        L = tril(A);

        for k = 1 : t
            L(k,k) = 1;
        end

        D = diag(A);
        DD = zeros(t,t);

        for k = 1 : t
            DD(k,k) = D(k);
        end

        err = norm(AA - L*DD*L');
        errlu = norm(AA - LL*UU);
    end
    mfprintf(fic, "%.17lf %.17lf %.17lf %.17lf %d\n", err/iter, temps/iter, errlu/iter, tempslu/iter, t);
end
mclose (fic);
