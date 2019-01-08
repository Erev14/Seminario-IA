%Evoluci�n Diferencial con Penalizaci�n (Primer M�todo)

f = @(x,y) sin(x+y) + ((x-y).^2) - 1.5*x + 2.5*y + 1 %McCormick

F = 0.8;
CR = 0.5;
G = 100;
N = 70;
D = 2;

x = zeros(D,N);
v = zeros(D,N);
u = zeros(D,N);
fit = zeros(1,N);
xfit = zeros(1,G);

xl = [-160; -150; -135];
xu = [160; 150; 135];

p_final = [0.8; 0.2; 0.3];
q = [30; 60; 80]*(pi/180);
Dibujar_Manipulador(q,xl,xu,p_final);

for i=1:N
    x(:,i) = xl + (xu-xl).*rand(D,1);
end

for gen=1:G
    Plot_Contour (f,x,xl,xu);
    for i=1:N
        fit(i) = f(x(1,i),x(2,i));

        r1 = randi([1,N]);
        r2 = randi([1,N]);
        r3 = randi([1,N]);

        while(r1 == r2 || r2 == r3 || r1 == i || r2 == i || r3 == i)
            r1 = randi([1,N]);
            r2 = randi([1,N]);
            r3 = randi([1,N]);
        end

        v(:,i) = x(:,r1) + F *((x(:,r2)) - (x(:,r3)));
        ra = rand;

        for j=1:D
            if(ra <= CR)
                u(j,i) = v(j,i);
            else
                u(j,i) = x(j,i);
            end
        end

        %C�lculo de Penalizaci�n
        P = 0;
        for j=1:D
            if(xl(j)<= u(j,i) && xu(j)>= u(j,i))
                g = 0;
            else
                g = 1;
            end
            P = P + 1000*g; %Penalizaci�n.
        end

        if((f(u(1,i),u(2,i))+ P) < f(x(1,i),x(2,i)))%Comparaci�n incluyendo penalizaci�n.
            x(:,i) = u(:,i);
        end
    end
    [best,k] = min(fit);
    xfit(gen) = best;
end
out=strcat('f(x,y) = ', num2str(best),'\rightarrow x=',num2str(x(1,k)),'\rightarrow y=',num2str(x(2,k)));
l=legend(out);
l.FontSize = 12;

figure
Plot_Surf (f,x,xl,xu);
l=legend(out);
l.FontSize = 12;
figure
plot(xfit);
