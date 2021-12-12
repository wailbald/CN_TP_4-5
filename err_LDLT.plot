set term png size 700,700

set output "LDLT_erreur.png"

set grid

set ylabel "erreur"
set xlabel "matrice de taille n*n"

plot "LDLT.dat" using 6:1 t "erreur LDLT" w lp;