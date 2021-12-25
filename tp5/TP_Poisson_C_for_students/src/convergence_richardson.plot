set term png size 700,700

set output "convergence_richardson.png"

set grid

set logscale y

set ylabel "valeur"
set xlabel "itération"

plot "myrichardson12.dat" using 2:1 t "convergence1/2" w l,"myrichardson13.dat" using 2:1 t "convergence1/3" w l,"myrichardson14.dat" using 2:1 t "convergence1/4" w l,"myrichardson16.dat" using 2:1 t "convergence1/6" w l;