clear all
close all
clc

% Vector de posiciones
q = [30; 60; 80]*(pi/180);

l1 = 0.5;
l2 = 0.5;

p = [0.0; 0.0; 0.0];
p(1) = -sin(q(1)-pi/2)*(l1*cos(q(2))+l2*cos(q(2)+q(3)));
p(2) = cos(q(1)-pi/2)*(l1*cos(q(2))+l2*cos(q(2)+q(3)));
p(3) = l1*sin(q(2))+l2*sin(q(2)+q(3));

disp(['Posicion actuador final: (' num2str(p(1)) ',' num2str(p(2)) ',' num2str(p(3)) ')'])

p_final = [0.8; 0.2; 0.3];

Dibujar_Manipulador(q,l1,l2,p_final);
