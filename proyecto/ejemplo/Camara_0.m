clc,clear all;
%%%DETECCIÓN DE OBJETOS
imaqhwinfo 
cam=imaqhwinfo; 
cam.InstalledAdaptors
vid=videoinput('winvideo',1); 
preview(vid); %visualizar camara

%CONFIGURACIÓN
for T=1:100 


im=getsnapshot(vid);             %foto instantanea 
[b, num]=CapBinaria(im);         %Obtener imagen en FORMATO BINARIO
[B,L]= bwboundaries(b,'holes');  %Agujeros negros
figure(2)
fill=imfill(L,'holes');          %LLenar agujeros
Ibw = imfill(fill,'holes');
[Ilabel, Ne]= bwlabel(Ibw);          %Ne numero de obejtos blancos
stat = regionprops(Ilabel, 'centroid');     %Obtener(Area,Centroide,Limites)                          

imshow(im)  
hold on

for x = 1: numel(stat)
if numel(stat)<2  
        
plot(stat(x).Centroid(1),stat(x).Centroid(2),'x');   
xc=stat(x).Centroid(1);
yc=stat(x).Centroid(2);
radius=25;
theta = 0:0.01:2*pi;
Xfit = radius*cos(theta) + xc;
Yfit = radius*sin(theta) + yc;
plot(Xfit, Yfit, 'y', 'LineWidth', 4);
fprintf('\n--------OBJETO DETECTADO--------\n');
fprintf('\nPosicion:\n');
fprintf('Abscisa%10.3f\n',xc)
fprintf('Ordenada%10.3f\n',yc)

end
end
pause(0.05);
end