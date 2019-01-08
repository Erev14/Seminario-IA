clear all
close all
clc

f = @(x) x.^4 + 5*x.^3 + 4*x.^2 - 4*x + 1; % funcion objetivo

xl = -4; % límite superior
xu = 1; % límite inferior

x = xl:0.1:xu; % 0.1 define el paso de xl a xu

figure
hold on % para poder graficar más de una vez en un mismo plot
grid on % genera una cuadricula en el plot

plot(x,f(x),'-b','LineWidth',2,'MarkerSize',10) % crea el plot con estilo de linea '-', color 'b', ancho de linea '2' y tamaño del marcador '10'
plot(-2,f(-2),'*r','LineWidth',2,'MarkerSize',10) % agregamos un punto extra al grafico con estilo '*', color 'r', ancho de linea '2' y tamaño del marcador '10'

xlabel('eje x') % etiqueta en el eje x
ylabel('eje y') % etiqueta en el eje y
