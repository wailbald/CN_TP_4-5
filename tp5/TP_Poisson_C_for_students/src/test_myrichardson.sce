exec ./myrichardson.sce

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

[x,nbiter,vres] = myrichardson(A,b,1e-10,100000,1/2);
[x,nbiter,vres2] = myrichardson(A,b,1e-10,100000,1/3);
[x,nbiter,vres3] = myrichardson(A,b,1e-10,100000,1/4);
[x,nbiter,vres4] = myrichardson(A,b,1e-10,100000,1/6);

[fic1, mod] = mopen("myrichardson12.dat", "w");
[fic2, mod] = mopen("myrichardson13.dat", "w");
[fic3, mod] = mopen("myrichardson14.dat", "w");
[fic4, mod] = mopen("myrichardson16.dat", "w");

for i = 1 : length(vres)
    mfprintf(fic1,"%.17lf %d\n",vres(i),i);
end
mclose(fic1);

for i = 1 : length(vres2)
    mfprintf(fic2,"%.17lf %d\n",vres2(i),i);
end
mclose(fic2);

for i = 1 : length(vres3)
    mfprintf(fic3,"%.17lf %d\n",vres3(i),i);
end
mclose(fic3);

for i = 1 : length(vres4)
    mfprintf(fic4,"%.17lf %d\n",vres4(i),i);
end
mclose(fic4);
