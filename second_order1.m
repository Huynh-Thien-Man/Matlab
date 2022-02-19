function [y z] = second_order1(a,b,fy,fz,t0,y0,z0,h,m)
t(1) = t0;
y(1) = y0;
z(1) = z0;
n = (b-a)/h;
  switch m
%Euler
    case 1
for i = 1:n
  y(i+1,1) = y(i) + h*fy(t(i),y(i),z(i));
  z(i+1,1) = z(i) + h*fz(t(i),y(i),z(i));
  t(i+1,1) = t0 + i*h;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Runge Kutta Order 2:
    case 2
for i = 1:n
    t(i+1,1) = t0 + i*h;
    k1y = fy(t(i),y(i),z(i));
    k1z = fz(t(i),y(i),z(i));
    
    k2y = fy(t(i+1), y(i) + h*k1y, z(i) + h*k1z);
    k2z = fz(t(i+1), y(i) + h*k1y, z(i) + h*k1z);
    
    y(i+1,1) = y(i) + (h/2)*(k1y + k2y);
    z(i+1,1) = z(i) + (h/2)*(k1z + k2z);  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Runge Kutta Order 4:
    case 3
for i = 1:n
    t(i+1,1) = t0 + i*h;
    k1y = fy(t(i),y(i),z(i));
    k1z = fz(t(i),y(i),z(i));
    
    k2y = fy(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    k2z = fz(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    
    k3y = fy(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    k3z = fz(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    
    k4y = fy(t(i+1), y(i) + h*k3y, z(i) + h*k3z);
    k4z = fz(t(i+1), y(i) + h*k3y, z(i) + h*k3z);

    y(i+1,1) = y(i) + (h/6)*(k1y + 2*k2y + 2*k3y + k4y);    
    z(i+1,1) = z(i) + (h/6)*(k1z + 2*k2z + 2*k3z + k4z);     
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predictor - Corrector - Adam
    case 4
    for i = 1:n
    t(i+1,1) = t0 + i*h;
    k1y = fy(t(i),y(i),z(i));
    k1z = fz(t(i),y(i),z(i));
    
    k2y = fy(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    k2z = fz(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    
    k3y = fy(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    k3z = fz(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    
    k4y = fy(t(i+1), y(i) + h*k3y, z(i) + h*k3z);
    k4z = fz(t(i+1), y(i) + h*k3y, z(i) + h*k3z);

    y(i+1,1) = y(i) + (h/6)*(k1y + 2*k2y + 2*k3y + k4y);    
    z(i+1,1) = z(i) + (h/6)*(k1z + 2*k2z + 2*k3z + k4z);     
end
for i = 5:n
    t(i+1,1) = t0 + i*h;
    y(i+1,1)=y(i) +(h/24)*( -9*fy(t(i-3),y(i-3),z(i-3)) +37*fy(t(i-2),y(i-2),z(i-2))...
                        -59*fy(t(i-1),y(i-1),z(i-1)) +55*fy(t(i),y(i),z(i)));
    z(i+1,1)=z(i) +(h/24)*( -9*fz(t(i-3),y(i-3),z(i-3)) +37*fz(t(i-2),y(i-2),z(i-2))...
                        -59*fz(t(i-1),y(i-1),z(i-1)) +55*fz(t(i),y(i),z(i)));
p1=y;
p2=z;
          y(i+1,1)=y(i) +(h/24)*( fy(t(i-2),y(i-2),z(i-2)) -5*fy(t(i-1),y(i-1),z(i-1))...
                        +19*fy(t(i),y(i),z(i)) +9*fy(t(i+1),p1(i+1),p2(i+1)));
          z(i+1,1)=z(i) +(h/24)*( fz(t(i-2),y(i-2),z(i-2)) -5*fz(t(i-1),y(i-1),z(i-1))...
                        +19*fz(t(i),y(i),z(i)) +9*fz(t(i+1),p1(i+1),p2(i+1)));
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predictor - Corrector - Milne
case 5
      for i = 1:n
    t(i+1,1) = t0 + i*h;
    k1y = fy(t(i),y(i),z(i));
    k1z = fz(t(i),y(i),z(i));
    
    k2y = fy(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    k2z = fz(t(i) + h/2, y(i) + h/2*k1y, z(i) + h/2*k1z);
    
    k3y = fy(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    k3z = fz(t(i) + h/2, y(i) + h/2*k2y, z(i) + h/2*k2z);
    
    k4y = fy(t(i+1), y(i) + h*k3y, z(i) + h*k3z);
    k4z = fz(t(i+1), y(i) + h*k3y, z(i) + h*k3z);

    y(i+1,1) = y(i) + (h/6)*(k1y + 2*k2y + 2*k3y + k4y);    
    z(i+1,1) = z(i) + (h/6)*(k1z + 2*k2z + 2*k3z + k4z);     
        end
        for i = 5:n
          t(i+1,1) = t0 + i*h;
          y(i+1,1)= y(i-2) + (4*h/3)*(2*fy(t(i+1),y(i+1),z(i+1)) - fy(t(i-1),y(i-1),z(i-1)) + 2*fy(t(i),y(i),z(i)));
          z(i+1,1)= z(i-2) + (4*h/3)*(2*fz(t(i+1),y(i+1),z(i+1)) - fz(t(i-1),y(i-1),z(i-1)) + 2*fz(t(i),y(i),z(i)));
          p1=y;
          p2=z;
          y(i+1,1) = y(i) +(h/3)*(fy(t(i-1),y(i-1),z(i-1))+4*fy(t(i),y(i),z(i)) + fy(t(i+1),p1(i+1),p2(i+1)));
          z(i+1,1) = z(i) +(h/3)*(fz(t(i-1),y(i-1),z(i-1))+4*fz(t(i),y(i),z(i)) + fz(t(i+1),p1(i+1),p2(i+1)));
        end
end