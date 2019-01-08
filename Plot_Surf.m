function Plot_Surf (f,x,xl,xu)
    clf
    
    [xp,yp] = meshgrid(xl(1):0.1:xu(1),xl(2):0.2:xu(2));
    zp = f(xp,yp);
    surf(xp,yp,zp);
    
    [~,N] = size(x);
    fit = zeros(1,N);
    
    hold on
    grid on
    
    for i=1:N
        fit(i) = f(x(1,i),x(2,i));
        
		plot3(x(1,i),x(2,i),fit(i),'xb','LineWidth',2,'MarkerSize',10);
		plot3(x(1,i),x(2,i),fit(i),'or','LineWidth',2,'MarkerSize',10);
    end
    
    [~,k] = min(fit);
    
	plot3(x(1,k),x(2,k),fit(i),'xg','LineWidth',2,'MarkerSize',10);
	plot3(x(1,k),x(2,k),fit(i),'or','LineWidth',2,'MarkerSize',10);
    
    xlabel('x')
    ylabel('y')
    zlabel('f(x,y)')
    
    pause(0.1)
    