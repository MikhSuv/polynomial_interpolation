# Входной файл с результатами (два столбца: x y)
datafile = "res_chebyshev.dat"

# Выходной файл с графиком (можно изменить расширение)
set terminal pdfcairo enhanced color font "Arial,10"
set output "plot_result.pdf"

# Заголовок и подписи осей
set title "Интерполяция функции"
set xlabel "x"
set ylabel "L(x)"

# Стиль линии
plot datafile using 1:2 with lines title "L(x)"
