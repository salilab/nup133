#set terminal postscript eps size 3.5,2.62 color enhanced solid linewidth 2.5 font 'Arial,22'
#set terminal postscript eps color enhanced solid linewidth 2.5 font 'Arial,16'
#set output 'mes2_final.eps'
set terminal aqua enhanced font "Arial, 16"
#set terminal png enhanced font "Arial, 16";set output "fig2.png";

set key at 0.185, 0.13 Left reverse samplen 3
#set lmargin 2
#set rmargin 2
set multiplot
f(x)=1
set xrange [:0.3]
############################################
# Residual Plot
############################################
set origin 0,0
set size 0.8,0.3
set tmargin 0
set bmargin 3
set encoding iso_8859_1
set xlabel "q ({\305}^{-1})" font "Arial, 20"
set ylabel 'Residual ({/Arial}I_{cal.} / I_{exp.})' font "Arial, 20"
set format y ''
set xtics nomirror font 'Arial,18'
set ytics nomirror font 'Arial,18'
#set border 3
#set style line 11 lc rgb '#808080' lt 1
#set border 3 back ls 11
set yrange [0.3:1.7]
set xrange [:0.31]

plot f(x) notitle lc rgb '#333333', \
    './Vp133A_24159_LBNL_merged_q30.dat' u 1:($3/$2) notitle w lines lw 3.5 lc rgb '#e26261', \
    './Vp133B_24159_LBNL_merged_q30.dat' u 1:($3/$2) notitle w lines lw 3.5 lc rgb '#66ff00', \
    './Vp133.B99990096_MSE_24159_LBNL_merged_q30.dat' u 1:($3/$2) notitle w lines lw 3.5 lc rgb '#0000ff'

############################################
# Main Plot
############################################
set origin 0,0.3
set size 0.8,0.7
set bmargin 0
set tmargin 1
set xlabel ''
set format x ''
set ylabel 'I(q)  (a.u.)' font "Arial, 20"
set logscale y
set yrange [0.02:25.0]

plot './24159_LBNL_merged_q30.dat' u 1:2:3 with yerrorbars t 'experiment' lc rgb '#333333' pt 1 ps 0.5, \
    './Vp133A_24159_LBNL_merged_q30.dat' u 1:3 t '{VpNup133}^{55-502} chain A ({/Symbol c} = 4.08)' w lines lw 3.5 lc rgb '#e26261', \
    './Vp133B_24159_LBNL_merged_q30.dat' u 1:3 t '{VpNup133}^{55-502} chain B ({/Symbol c} = 3.58)' w lines lw 3.5 lc rgb '#66ff00', \
    './Vp133.B99990096_MSE_24159_LBNL_merged_q30.dat' u 1:3 t 'complete monomer ({/Symbol c} = 1.14)' w lines lw 3.5 lc rgb '#0000ff'


#=========================
#multiplot for Guiner plot
#=========================
set origin 0.42, 0.61
set size 0.35, 0.35
set xrange [0.00015:0.0012]
set yrange [2.6:2.88]
set xtics offset 0.0, 0.5 font "Arial, 11"
set xtics 0.0002, 0.0003
set ytics font "Arial, 11"
set encoding iso_8859_1
set xlabel "q^2  ({\305}^{-2})" offset 0.0, 1.0 font "Arial, 16"
set format x
set ylabel "log I(q)  (a.u.)" offset 2.2, 0.0 font "Arial, 14"
set format y
set nolog y
set title "Guinier Plot\n{/Arial=15 R_{g} = 25.45 {\261} 0.87{\305}}" offset 3.1, -3.1 font "Arial, 18"
#set key at 0.0046, 1500 samplen -1 font "Arial, 12" nobox

#=================================
#Guinier Fit
#=================================
a=1
b=1
c=1
d=1

f1(x) = a1*x + b1
fit f1(x) './24159_LBNL_merged_q30.dat' u ($1*$1):(log($2*a)) via a1, b1
f2(x) = a2*x + b2
fit f2(x) './Vp133A_24159_LBNL_merged_q30.dat' u ($1*$1):(log($3*b)) via a2, b2
f3(x) = a3*x + b3
fit f3(x) './Vp133B_24159_LBNL_merged_q30.dat' u ($1*$1):(log($3*c)) via a3, b3
f4(x) = a4*x + b4
fit f4(x) './Vp133.B99990096_MSE_24159_LBNL_merged_q30.dat' u ($1*$1):(log($3*d)) via a4, b4

set pointsize 0.7

plot './24159_LBNL_merged_q30.dat' u ($1*$1):2:3 thru log(x*a) with yerrorbars ls 3 lc rgb '#333333', \
    f2(x) ls 1 lw 3 lc rgb '#e26261', \
    f3(x) ls -1 lw 3 lc rgb '#66ff00', \
    f4(x) ls 2 lw 3 lc rgb '#0000ff'

set nomultiplot
set encoding default

unset multiplot