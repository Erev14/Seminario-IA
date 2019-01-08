function Plot_Contour (f,x,xl,xu)
    clf
    
    [xp,yp] = meshgrid(xl(1):0.1:xu(1),xl(2):0.1:xu(2));
    zp = f(xp,yp);
    contour(xp,yp,zp,20);
    
    [~,N] = size(x);
    fit = zeros(1,N);
    
    hold on
    grid on
    
    for i=1:N
		plot(x(1,i),x(2,i),'xb','LineWidth',2,'MarkerSize',10);
		plot(x(1,i),x(2,i),'or','LineWidth',2,'MarkerSize',10);
        fit(i) = f(x(1,i),x(2,i));
    end
    
    [~,k] = min(fit);
    
	plot(x(1,k),x(2,k),'xg','LineWidth',2,'MarkerSize',10);
	plot(x(1,k),x(2,k),'or','LineWidth',2,'MarkerSize',10);
    
    xlabel('x')
    ylabel('y')
    zlabel('f(x,y)')
    
    pause(0.01)
    