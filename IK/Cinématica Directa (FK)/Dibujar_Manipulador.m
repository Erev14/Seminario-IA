function Dibujar_Manipulador (q,l1,l2,p_final)
    % Dibujar manipulador
    T = @(theta,a,d,alpha) ...
         [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);...
          sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);...
          0 sin(alpha) cos(alpha) d; 0 0 0 1];
    
    T1 = T(q(1),0.0,0.0,pi/2);
    T2 = T(q(2),l1,0.0,0.0);
    T3 = T(q(3),l2,0.0,0.0);
    
    T12 = T1*T2;
    T13 = T12*T3;
    
    p1 = T1(1:3,4);
    p2 = T12(1:3,4);
    p3 = T13(1:3,4);
    
    figure
    grid on
    hold on
    view([-35,35])
    
    xlabel('x'); ylabel('y'); zlabel('z');
    axis([-1.2 1.2 -1.2 1.2 0 1]);
    
    plot3(p1(1),p1(2),p1(3),'bo','MarkerSize',15,'LineWidth',4)
    plot3(p2(1),p2(2),p2(3),'bo','MarkerSize',15,'LineWidth',4)
    plot3(p3(1),p3(2),p3(3),'bo','MarkerSize',15,'LineWidth',4)

    line([p1(1) p2(1)],[p1(2) p2(2)],[p1(3) p2(3)],'color',[0 0 1],'LineWidth',5)
    line([p2(1) p3(1)],[p2(2) p3(2)],[p2(3) p3(3)],'color',[0 0 1],'LineWidth',5)
    
    plot3(p_final(1),p_final(2),p_final(3),'rx','MarkerSize',15,'LineWidth',4)
