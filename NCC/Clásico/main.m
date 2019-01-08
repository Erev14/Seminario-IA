clear all
close all
clc

img = imread('Image_2.bmp');
temp = imread('Template.bmp');

img_g = rgb2gray(img);
temp_g = rgb2gray(temp);

[img_H,img_W] = size(img_g);
[temp_H,temp_W] = size(temp_g);

val_max = -1;
xp = 0;
yp = 0;

for y=1:(img_H-temp_H)
    for x=1:(img_W-temp_W)
        val = NCC(img_g,temp_g,x,y);
        
        if val > val_max
            val_max = val;
            xp = x;
            yp = y;
        end   
    end
end

figure
hold on

imshow(img)

line([xp xp+temp_W], [yp yp],'Color','g','LineWidth',3);
line([xp xp], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp+temp_W xp+temp_W], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp xp+temp_W], [yp+temp_H yp+temp_H],'Color','g','LineWidth',3);
