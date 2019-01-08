clear all
close all
clc

G = 100;
N= 100;
D = 3;
F=1;
CR=.5;

ql = [-160; -150; -135];
qu = [160; 150; 135];

v = zeros(D,N);
u = zeros(D,N);

f = @(p_final,p) norm(p_final - p);

fitnes = zeros(1,N);

q  = zeros(D,N);

l1 = 0.5;
l2 = 0.5;
p_final = [0.5; 0.1; 0.3];

for i=1:N
    q(:,i) = ql + (qu-ql).*rand(D,1);
end
for g=1:1:G
    pause(.2);
    close all
    Dibujar_Manipulador (q(:,i),l1,l2,p_final);
    for i=1:1:N
    
    r1=randi([1 N],1);
    while(r1==i)
        r1=randi([1 N],1);
    end
    r2=randi([1 N],1);
    while(r2==r1 || r2==i)
    r2=randi([1 N],1);
    end
    r3 = randi([1 N],1);
    while(r3==r1 || r3==r2 ||r3==i)
    r3=randi([1 N],1);
    end
    
    v(1,i) = q(1,r1) + F *(q(1,r2)-q(1,r3));
    v(2,i) = q(2,r1) + F *(q(2,r2)-q(2,r3));
    v(3,i) = q(3,r1) + F *(q(3,r2)-q(3,r3));

    for j=1:1:D 
        ra = rand;
        if(ra <= CR)
            u(j,i) = v(j,i);
        else
            u(j,i) = q(j,i);
        end
    end
    
    if(f(p_final, cinematica(u(:,i),l1,l2)) < f(p_final, cinematica(q(:,i),l1,l2)))
        
        penalizacionX = Penalizacion(u(1,i),ql,qu);
        penalizacionY = Penalizacionye(u(2,i),ql,qu);
        penalizacionZ = PenalizacionZe(u(3,i),ql,qu);
        
        if(penalizacionX == 1 || penalizacionY == 1 || penalizacionZ == 1)
           u(1,i)=randi([0 320],1) - 160;
           u(2,i)=randi([0 300],1) -150;
           u(3,i)=randi([0 270],1) -135;
           
        else
            
        q(1,i) = u(1,i);
        q(2,i) = u(2,i);
        q(3,i) = u(3,i);
        end        
    end
    end
    
    for i=1:1:N
            fitnes(i)= f(p_final,cinematica(q(:,i),l1,l2));
    end
end
[~,ind] = min(fitnes);
    
    Dibujar_Manipulador (q(:,ind),l1,l2,p_final);
    cinematica(q(:,ind),l1,l2)
    disp(['La mejor solucion es: ', num2str(fitnes(ind))]);
    disp(['Con X=: ', num2str(q(1,ind)),', Y= ',num2str(q(2,ind)),', Z= ',num2str(q(3,ind))]);

function [p] = Penalizacion(x,xl,xu)
    p=0;
    if(xl(1) < x && x < xu(1))
       p=p+0;
    else
       p=p+1;   
    end
end

function [p] = Penalizacionye(x,xl,xu)
    p=0;
    if(xl(2) < x && x < xu(2))
       p=p+0;
    else
       p=p+1;   
    end
end

function [p] = PenalizacionZe(x,xl,xu)
    p=0;
    if(xl(3) < x && x < xu(3))
       p=p+0;
    else
       p=p+1;   
    end
end

function [p] =  cinematica(q,l1,l2)
q = q*(pi/180);
p = [0.0; 0.0; 0.0];
p(1) = -sin(q(1)-pi/2)*(l1*cos(q(2))+l2*cos(q(2)+q(3)));
p(2) = cos(q(1)-pi/2)*(l1*cos(q(2))+l2*cos(q(2)+q(3)));
p(3) = l1*sin(q(2))+l2*sin(q(2)+q(3));
end
