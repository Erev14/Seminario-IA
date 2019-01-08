clear all
close all
clc

f = @(x,y) (x-2).^2 + (y-2).^2; % funcion objetivo

xl = -10; % límite superior en x
xu = 10; % límite inferior en x

yl = -10; % límite superior en y
yu = 10; % límite inferior en y

[x,y] = meshgrid(xl:0.2:xu,yl:0.2:yu); % creamos una rejilla de puntos (x,y) para crear el plot
z = f(x,y); % evaluacion de cada elemento en la rejilla para crear su valor en el eje z

figure
hold on
grid on
surf(x,y,z) % plot de la rejilla en 3D
plot3(3,3,f(3,3),'rx','LineWidth',2,'MarkerSize',10) % plot de un punto cualqueira en 3D
xlabel('x')
ylabel('y')
zlabel('f(x,y)')
view([-20,60]) % estos valores definen la vista 3D del plot

figure
hold on
grid on
contour(x,y,z,20) % plot de la rejilla en 2D
plot(3,3,'rx','LineWidth',2,'MarkerSize',10) % plot de un punto cualqueira en 2D
xlabel('x')
ylabel('y')
zlabel('f(x,y)')
