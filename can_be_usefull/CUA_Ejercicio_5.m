% Programador: Alfredo Carréon Urbano.
% Fecha: 16 de septiembre de 2018.
% Programa: Encuentre el mínimo global de las siguientes funciones, 
% utilizando la Estrategia Evolutiva (1 + 1)-ES Adaptativa:

clear all
close all
clc
disp('(1+1)-ES')

% Ingresar las funciones:
%f = @ (x,y) x.*exp(-x.^2-y.^2);
f = @(x,y)  (x-2).^2 + (y-2).^2; 

G = 250; % Generaciones.
% Limites inferior y superior.
xl = [-2; -2]; 
xu = [2; 2];
D = 2; % Dimenciones
sigma = 0.5;
ne = 0;
c = 0.817;
Pe = 0; %Porcentaje de exitos

xp = xl + (xu-xl).*rand(D,1); 

figure
for i=1:G
    r = normrnd(0,sigma,[2,1]); % Generar vector aleatorio.
    xh = xp + r; % Mutación.
    
    % Graficando.
    Plot_Contour(f,xh,xl,xu);
    Plot_Contour(f,xp,xl,xu);
    
    if f(xh(1),xh(2)) < f(xp(1),xp(2))
        xp = xh;
        ne = ne+1;
    end
    
    % Etapa de Ajuste
    Pe = ne/i;
    if Pe < 1/5
        sigma = c^2 * sigma; 
    elseif Pe > 1/5
        sigma = sigma / c^2;    
    end
end

% Graficando.
out=strcat('f(x,y) = ', num2str(f(xp(1),xp(2))),'\rightarrow x=',num2str(xp(1)),'\rightarrow y=',num2str(xp(2)));
legend(out);