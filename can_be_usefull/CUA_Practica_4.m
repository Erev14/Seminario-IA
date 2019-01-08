% Algoritmo Evolutivo.
% Programador: Alfredo Carreón Urbano.
% Fecha: 23 de Septiembre de 2018.
% Programa: Realiza un programa de cómputo que encuentre el mínimo global de las
% siguientes funciones, utilizando la Estrategia Evolutiva (? + ?)-ES y (?, ?)-ES:

clear all
close all
clc

% Ingresar función.
f = @(x,y) x.*exp(-x.^2-y.^2);
% f = @(x,y)  (x-2).^2 + (y-2).^2;

% Inicializar los valores.
G = 200;
H = 30;
mu = 50;
D = 2;

x = zeros(D,mu+H);
sigma = zeros(D,mu+H);
fitness = zeros(1,mu+H);

% Limites.
xl = [-2; -2];
xu = [2; 2];

method = 0; % 1 es true y 0 es false.

% Generar aleatoriamente a individuos.
for i=1:mu
    x(:,i) = xl + (xu-xl).*rand(D,1);
    sigma(:,i) = 0.5*rand(D,1);
end

figure % Ventana para graficar.

% Cumplir con el total de generaciones.
for g=1:G
    Plot_Contour(f,x,xl,xu) % Graficando.
    
    for i=1:H
        % Seleccionar aleatoriamente a los padres.
        r1 = randi([1,mu]);
        r2 = r1;
        
        while r1==r2
            r2 = randi([1,mu]);
        end
        
        % Rebobinar los padres para crear un hijo.
        x(1,mu+i) = (x(1,r1)+x(1,r2))/2;
        x(2,mu+i) = (x(2,r1)+x(2,r2))/2;
        
        sigma(1,mu+i) = (sigma(1,r1)+sigma(1,r2))/2;
        sigma(2,mu+i) = (sigma(2,r1)+sigma(2,r2))/2;
        
        % Generar vector aleatorio.
        r = normrnd(0,sigma(:,mu+i));
        x(:,mu+i) = x(:,mu+i) + r;
    end
    
    % Seleccionar a los mejores individuos.
    if (method == 1)
        for i=1:H
            x(:,i) = x(:,mu+H);
        end
    end
    
    for i=1:mu+H
        fitness(i) = f(x(1,i),x(2,i));
    end
    
    [~,ind] = sort(fitness); % Sort es para ordenar.
    fitness = fitness(ind);
    x = x(:,ind);
    sigma = sigma(:,ind);
end