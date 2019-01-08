clear
close all

syms x y z
fun = ((2*x) + 2 - 8).^2 + ((4*x) + (3*y) + (5*z) - 25 +x + (2*z) - 4).^2 + ((3*x) + y + (10*z) - 20).^2;
f = inline(fun);
fbest = 999999;
xbest = 0;
ybest = 0;
zbest = 0;
rx = 0;
ry = 0;
rz = 0;
xl = -5;
xu = 5;
yl = -5;
yu = 5;
zl = -5;
zu = 5;

for i=0:1:10000
    rx = rand;
    ry = rx;
    while (ry == rx)
    ry = rand;
    end
    rz = rand;
    while rz == rx || rz==ry
        rz = rand;
    end
    x = xl+(xu-xl)*rx;
    y = yl+(yu-yl)*ry;
    z = zl+(zu-zl)*rz;
    
    fval = f(x,y,z);
    if fval < fbest
        fbest = fval;
        xbest = x;
        ybest = y;
        zbest = z;
    end    
end
    e1 = (2*xbest) + ybest
    e2 = (4*xbest) + (3*ybest) + (5*zbest)
    e3 = xbest + (2*zbest)
    e4 = (3*xbest) + ybest + (10*zbest)