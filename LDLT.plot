set term png size 700,700

set output "LDLT_performance.png"

set grid

set logscale y

set ylabel "temps"
set xlabel "matrice de taille n*n"

plot "LDLT.dat" using 6:2 t "temps LDLT" w lp, "LDLT.dat" using 6:3 t "temps mylu" w lp, "LDLT.dat" using 6:4 t "temps mylu1b" w lp, "LDLT.dat" using 6:5 t "temps mylu3b" w lp;