exec ./myjacobi.sce

function [A] = init_matrix(n)

    A = zeros(n, n);
    for i = 1:n-1
        A(i + 1, i) = -1;
        A(i,i) = 2;
        A(i, i + 1) = -1;
    end
    A(n,n) = 2;

endfunction

function [b] = init_vector(n, T0, T1)

    b = zeros(n, 1);

    b(1) = T0;
    b(n) = T1;

endfunction

A = init_matrix(100);
b = init_vector(100,-5,5);

disp(A);
disp(b);

[x,nbiter,vres] = myjacobi(A,b,1e-10,100000);

disp(norm(A\b -x)/norm(A));

[fic, mod] = mopen("myjacobi.dat", "w");

for i = 1 : length(vres)
    mfprintf(fic,"%.17lf %d\n",vres(i),i);
end

mclose(fic);
