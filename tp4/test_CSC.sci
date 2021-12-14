exec ./CSC.sci
exec ./CSCT.sci

ligne = 9;
colonne = 5;
A = sprand(ligne, colonne, 0.25);
A = full(A);
disp(A);

[AA,JA,IA] = myCSC(A);
disp(AA);
disp(JA);

disp(A');
[AAT, JAT, IAT] = myCSCT(AA,JA,IA,size(A,1),size(A,2));
disp(AAT);
disp("JAT");
disp(JAT);
