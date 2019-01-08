clear all
close all
clc

% f = @(x,y)  (x-2).^2 + (y-2).^2;
 f = @(x,y) x.*exp(-x.^2-y.^2);
 
G = 10000;
mu = 50;
D = 2;

x = zeros(D,mu+1);
sigma = zeros(D,mu+1);
fitness = zeros(1,mu+1);

xl = [-2; -2];
xu = [2; 2];

for i=1:mu
    x(:,i) = xl + (xu-xl).*rand(D,1);
    sigma(:,i) = 0.5*rand(D,1);
end

figure

for g=1:G
    Plot_Contour(f,x,xl,xu)
    
    r1 = randi([1,mu]);
    r2 = r1;
    
    while r1==r2
        r2 = randi([1,mu]);
    end
    
    x(1,mu+1) = (x(1,r1)+x(1,r2))/2;
    x(2,mu+1) = (x(2,r1)+x(2,r2))/2;
    
    sigma(1,mu+1) = (sigma(1,r1)+sigma(1,r2))/2;
    sigma(2,mu+1) = (sigma(2,r1)+sigma(2,r2))/2;
    
    r = normrnd(0,sigma(:,mu+1));
    x(:,mu+1) = x(:,mu+1) + r;
    
    for i=1:mu+1
        fitness(i) = f(x(1,i),x(2,i));
    end
    
    [~,ind] = sort(fitness);
    
    fitness = fitness(ind);
    x = x(:,ind);
    sigma = sigma(:,ind);
end







