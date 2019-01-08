%Martha Isabel Mungu�a Cervantes
%Agoritmo Gen�tico
clc
syms x y
%Elegir funci�n
f = @ (x,y) x.*exp(-x.^2-y.^2) %Funci�n 1
%f = @ (x,y) ((x-2).^2) + ((y-2).^2) %Funci�n 2

poblacion = 50 %n�mero de poblaci�n
generaciones = 15
D = 2 %dimensi�n del problema
Pm = 0.1 %Probabilidad de mutaci�n
aptitud=[] %aptitud de cada individuo
p=[] %probabilidad de ser elegido
ap_total = 0 %aptitud de la poblacion 

xl = -2
xu = 2
yl = -2
yu = 2

fval = 9999
fbest = 9999

str = strrep(char(f),'@(x)','')
[x,y] = meshgrid(-2.5:0.01:2.5,-2.5:0.01:2.5); % creamos una rejilla de puntos (x,y) para crear el plot
z = f(x,y); % evaluacion de cada elemento en la rejilla para crear su valor en el eje z
hold on
grid on
contour(x,y,z,20) % plot de la rejilla en 2D
xlabel('x')
ylabel('y')

for i=1:poblacion %Generaci�n de la poblaci�n (Inicializaci�n)
    xi = xl+(xu-xl)*rand
    yi = yl+(yu-yl)*rand
    
    individuo_x(i)= xi
    individuo_y(i)= yi

    if (f(xi,yi)<fval)
        fval = f(xi,yi)
        xbest = xi
        ybest = yi
    end
    Plot1(i) = plot(xi,yi,'r*','LineWidth',2,'MarkerSize',5) % plot de un punto cualqueira en 2D
end

Plot2=plot(xbest,ybest,'b*','LineWidth',2,'MarkerSize',8) % plot de un punto cualqueira en 2D 
title(str)

for g=1:generaciones %Algoritmo Gen�tico
    
    for i=1:poblacion %C�lculo de aptitud (Evaluaci�n de la funci�n)      
        fxy = f(individuo_x(i),individuo_y(i))    
        if(fxy >= 0)
            aptitud(i) = 1 / (1+fxy)
        else
            aptitud(i) = 1 + abs(fxy)
        end
        ap_total = ap_total + aptitud(i)
    end
    
    %Selecci�n por ruleta
    for i=1:poblacion
        p(i) = aptitud(i) / ap_total
    end
    
    for j=1:poblacion
        r=rand
        Psum = 0
        for i=1:poblacion
            
            Psum = Psum + p(i)
            
            if(Psum >= r)
                padre_x(j) = individuo_x(i)
                padre_y(j) = individuo_y(i)
                break
            end
        end
    end
    
    %Cruza
    for i=1:poblacion-2 %Asegurar cruce de padres diferentes      
        if(f(padre_x(i),padre_y(i)) == f(padre_x(i+1),padre_y(i+1)))
            
            tmp_x = padre_x(i+1)
            tmp_y = padre_y(i+1)
            
            padre_x(i+1) = padre_x(i+2)
            padre_y(i+1) = padre_y(i+2)
            
            padre_x(i+2) = tmp_x
            padre_y(i+2) = tmp_y
        end
    end
    
    for i=1:2:poblacion %Generaci�n de hijos      
        hijo_x(i)=padre_x(i)
        hijo_y(i)=padre_y(i+1)
        
        hijo_x(i+1)=padre_x(i+1)
        hijo_y(i+1)=padre_y(i)
    end
    
    %Mutaci�n
    for i=1:poblacion
        for j=1:D
            ra = rand
            if ra < Pm
                rb = rand
                if D==1
                    hijo_x(i) = xl + (xu-xl)*rb %Mutaci�n en cromosoma x
                else
                    hijo_y(i) = xl + (xu-xl)*rb %Mutaci�n en cromosoma y
                end
            end
        end
    end
    
    pause (0.3)
 
    for i=1:poblacion % Sustituci�n de padres por los hijos
        individuo_x(i)=hijo_x(i)
        individuo_y(i)=hijo_y(i)
         
        if (f(hijo_x(i),hijo_y(i))<fval)
            xbest = hijo_x(i)
            ybest = hijo_y(i)
            fval = f(xbest,ybest)     
        end     
        delete(Plot1(i))
        Plot1(i) = plot(hijo_x(i),hijo_y(i),'r*','LineWidth',2,'MarkerSize',5) % plot de un punto cualqueira en 2D     
    end
    
    if(fval<fbest)
        fbest = fval
        X = xbest
        Y = ybest
        delete(Plot2)
        Plot2=plot(X,Y,'b*','LineWidth',2,'MarkerSize',9) % plot de un punto cualqueira en 2D
    end
end
out=strcat('f(x,y) = ', num2str(f(X,Y)),'\rightarrow x=',num2str(X),'\rightarrow y=',num2str(Y))
l=legend(out)
l.FontSize = 12;

