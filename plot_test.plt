set terminal pdfcairo enhanced color font "Arial, 10"
set output "test.pdf"

set title "Интерполяция"
set xlabel "x"
set ylabel "f(x)"

plot "res_sin_chebyshev.dat" using 1:2 with points  pt 1 lc rgb "red" title "Чебышевская сетка", \
sin(x) with lines lc rgb "blue" title "sin(x)"

plot "res_x_uniform.dat" using 1:2 with points pt 1 lc rgb "red" title "Равномерная сетка", \
x with lines lc rgb "blue" title "f(x) = x" 

plot "res_runge_chebyshev.dat" using 1:2 with points pt 1 lc rgb "red" title "Чебышевская сетка", \
"res_runge_uniform.dat" using 1:2 with points pt 1 lc rgb "green" title "Равномерная сетка", \
1/(1+x*x) with lines lc rgb "blue" title "1/(1+x^2)"

plot "res_const_chebyshev.dat" using 1:2 with points pt 1 lc rgb "red" title "Чебышевская сетка", \
"res_const_uniform.dat" using 1:2 with points pt 1 lc rgb "green" title "Равномерная сетка", \
cos(3) with lines lc rgb "blue" title "f(x) = cos(3)"
