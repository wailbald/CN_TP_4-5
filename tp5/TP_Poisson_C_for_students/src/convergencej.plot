set term png size 700,700

set output "convergence_jacobi.png"

set grid

set logscale y

set ylabel "valeur"
set xlabel "itération"

plot "myjacobi.dat" using 2:1 t "convergence" w l;