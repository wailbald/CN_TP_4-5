set term png size 700,700

set output "err_matvec.png"

set grid

set ylabel "erreur"
set xlabel "matrice de taille n*n"

plot "matvecCSR.dat" using 2:1 t "err_matvec" w lp;