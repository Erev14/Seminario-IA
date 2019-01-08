clear all
close all
clc
 

%% Funcion 1 Busqueda Aleatoria

##f = @(x,y) x.*exp(-x.^2-y.^2);        
##fg = 0.42888; xg = 0.70711; yg = 0;
##
##xl = -2;
##xu = 2;
##
##yl = -2;
##yu = 2;
##
##fb = 999;
##xb = 0;
##yb = 0;
##
##for i=0:10000    
##  x = xl + (xu - xl)*rand;
##  y = yl + (yu - yl)*rand;
##  fv = x*(exp(1).^(-x.^2-y.^2));
##  if (fv < fb)
##    fb = fv;
##    xb = x;
##    yb = y;
##    end
##end
##
##[x,y] = meshgrid(xl:0.2:xu,yl:0.2:yu); 
##z = f(x,y);
##
##figure
##hold on
##grid on
##surf(x,y,z)
##plot3(xb,yb,fb,'ro','LineWidth',2,'MarkerSize',10)
##xlabel('x')
##ylabel('y')
##zlabel('f(x,y)')
##view([-20,60])
##
##figure
##hold on
##grid on
##contour(x,y,z,20)
##plot(xb,yb,'ro','LineWidth',2,'MarkerSize',10)
##xlabel('x')
##ylabel('y')
##zlabel('f(x,y)')

%% Funcion 2 Busqueda Aleatoria

 f = @(x,y) (x-2).^2 + (y-2).^2; 
 fg = 0; xg = [2,2];
 
 xl = -5;
 xu = 5;
 
 yl = -5;
 yu = 5;
 
 fb = 999;
 xb = 0;
 yb = 0;
 
 for i=0:10000    
   x = xl + (xu - xl)*rand;
   y = yl + (yu - yl)*rand;
   fv = (x-2).^2 + (y-2).^2;
   if (fv < fb)
     fb = fv;
     xb = x;
     yb = y;
     end
 end
 
 [x,y] = meshgrid(xl:0.2:xu,yl:0.2:yu); 
 z = f(x,y);
 
 figure
 hold on
 grid on
 surf(x,y,z)
 plot3(xb,yb,fb,'ro','LineWidth',2,'MarkerSize',10)
 xlabel('x')
 ylabel('y')
 zlabel('f(x,y)')
 view([-20,60])
 
 figure
 hold on
 grid on
 contour(x,y,z,20)
 plot(xb,yb,'ro','LineWidth',2,'MarkerSize',10)
 xlabel('x')
 ylabel('y')
 zlabel('f(x,y)')
  
 xb
 yb
 fb
## 
##%% Funcion 1 Gradiente Descendiente
##
##f = @(x,y) x.*exp(-x.^2-y.^2);        
##fg = 0.42888; xg = 0.70711; yg = 0;
##
##xl = -2;
##xu = 4;
##
##yl = -2;
##yu = 2;
##
##x = 1;
##y = 0;
##h = 0.1;
##
##dx = 0.01;
##dy = 0.01;
##
##for i=0:10000    
##
##x = x - h*(f(x + 0.5*dx, y) - f(x - 0.5*dx, y))/dx;
##y = y - h*(f(x, y + 0.5*dy) - f(x, y - 0.5*dy))/dy;
##
##end
##
##[xp,yp] = meshgrid(xl:0.2:xu,yl:0.2:yu); 
##zp = f(xp,yp);
##
##figure
##hold on
##grid on
##surf(xp,yp,zp)
##plot3(x,y,f(x,y),'ro','LineWidth',2,'MarkerSize',10)
##xlabel('x')
##ylabel('y')
##zlabel('f(x,y)')
##view([-20,60])
##
##figure
##hold on
##grid on
##contour(xp,yp,zp,20)
##plot(x,y,'ro','LineWidth',2,'MarkerSize',10)
##xlabel('x')
##ylabel('y')
##zlabel('f(x,y)')
##
##%% Funcion 2 Gradiente Descendiente
##
## f = @(x,y) (x-2).^2 + (y-2).^2;        
## fg = 0.42888; xg = 0.70711; yg = 0;
## 
## xl = -4;
## xu = 4;
## 
## yl = -4;
## yu = 4;
## 
## x = 3000;
## y = 0;
## h = 0.1;
## 
## dx = 0.01;
## dy = 0.01;
## 
## for i=0:10000    
## 
## x = x - h*(f(x + 0.5*dx, y) - f(x - 0.5*dx, y))/dx;
## y = y - h*(f(x, y + 0.5*dy) - f(x, y - 0.5*dy))/dy;
## 
## end
## 
## [xp,yp] = meshgrid(xl:0.2:xu,yl:0.2:yu); 
## zp = f(xp,yp);
## 
## figure
## hold on
## grid on
## surf(xp,yp,zp)
## plot3(x,y,f(x,y),'ro','LineWidth',2,'MarkerSize',10)
## xlabel('x')
## ylabel('y')
## zlabel('f(x,y)')
## view([-20,60])
## 
## figure
## hold on
## grid on
## contour(xp,yp,zp,20)
## plot(x,y,'ro','LineWidth',2,'MarkerSize',10)
## xlabel('x')
## ylabel('y')
## zlabel('f(x,y)')
%   
## x
## y
## f(x,y)