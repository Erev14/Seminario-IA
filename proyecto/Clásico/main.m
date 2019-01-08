clear all
close all
clc

function val = NCC(img,temp,x,y)
  [H,W] = size(temp);

  sum_img = 0.0;
  sum_temp = 0.0;
  sum_2 = 0.0;

  for i=1:W
    for j=1:H
      sum_img = sum_img + double(img(y+j,x+i))^2;
      sum_temp = sum_temp + double(temp(j,i))^2;
      sum_2 = sum_2 + double(img(y+j,x+i))*double(temp(j,i));
    end
  end

  val = sum_2/(sqrt(double(sum_img))*sqrt(double(sum_temp)));
end

function [ p ] = penalizacion( x,xl,xu )

  p = x;

  if x(1)>xl(1) && x(1)<xu(1)
    p(1) = x(1);
  else
    p(1) = xl(1)+(xu(1)-xl(1))*rand;
  end

  if xl(2)<x(2) && x(2)<xu(2)
    p(2) = x(2);
  else
    p(2) = xl(2)+(xu(2)-xl(2))*rand;
  end
end

img = imread('h.bmp');
temp = imread('t.bmp');

img_g = rgb2gray(img);
temp_g = rgb2gray(temp);

[img_H, img_W] = size(img_g);
[temp_H, temp_W] = size(temp_g);

val_max = -1;
xp = 0;
yp = 0;
xl = [1; 1];
xu = [img_H - temp_H; img_W - temp_W];

%------------Metodo Evolucion Diferencial
ff = 0.6;
cr = 0.9;
best = -1;

n = 50;
G = 150;
d = 2;
r = rand(d, 1);

x = zeros(d, n);
u = zeros(d, 1);
v = zeros(d, 1);

for i = 1 : n
      x(:, i) = xl + (xu - xl) .* rand(d, 1);
end

for g = 1 : G
  % Plot_Contour(f, x, xl, xu);

  for i = 1 : n
    r1 = randi( [1, n] );
    r2 = randi( [1, n] );
    r3 = randi( [1, n] );
    while(r1 == r2 || r2 == r3 || r1 == i || r2 == i || r3 == i)
      r1 = randi( [1, n] );
      r2 = randi( [1, n] );
      r3 = randi( [1, n] );
    end

    v = x(:, r1) + ff * ( x(:, r2) - x(:, r3) );
    for j = 1 : d
      if r < cr
        u(j) = v(j);
      else
        u(j) = x(j, i);
      end
    end

    u = penalizacion(u, xl, xu);


    if(NCC(img_g, temp_g, round( u(2) ),round( u(1) ) ) > NCC(img_g, temp_g, round( x(2, i) ),round( x(1, i) ) ) )
      x(:, i) = u;
    end
    fval = NCC(img_g, temp_g, round( x(2, i) ), round( x(1, i) ) );
    if fval > best
      best = fval;
      xp = x(2, i);
      yp = x(1, i);
    end
  end
end







%--------Fin metodo-----------
figure
hold on

imshow(img)

line([xp xp+temp_W], [yp yp],'Color','g','LineWidth',3);
line([xp xp], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp+temp_W xp+temp_W], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp xp+temp_W], [yp+temp_H yp+temp_H],'Color','g','LineWidth',3);
