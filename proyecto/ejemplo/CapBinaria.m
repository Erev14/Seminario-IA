function [im_yellow, num]=CapBinaria(im) 
[m,n,t]=size(im); 
im_yellow=zeros(m,n);  
num=0;
for i=1:m
    for j=1:n 
        if(im(i,j,1)>180&&im(i,j,2)>200&&im(i,j,3)>200) %limits of R,G and B for a particular colour
            im_yellow(i,j)=1; 
            num=num+1;
        end
    end
end