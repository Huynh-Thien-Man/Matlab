function y = onestepmethod(f,a,b,x0,y0,h,m)
t(1)=x0;
y(1)=y0;
t0 = x0;
% No. of steps
n = (b-a)/h;
  switch m
%Euler
    case 1
for i = 1:n
  y(i+1) = y(i) + h*f(t(i),y(i));
  t(i+1) = t0 + i*h;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Runge Kutta Order 2:
    case 2
for i = 1:n
    t(i+1) = t0 + i*h;
    k1 = f(t(i),y(i));
    k2 = f(t(i+1), y(i) + h*k1);
    k = [k1 k2];
    y(i+1) = y(i) + (h/2)*(k1 + k2);    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Runge Kutta Order 4:
    case 3
for i = 1:n
    t(i+1) = t0 + i*h;
    k1 = f(t(i),y(i));
    k2 = f(t(i) + h/2, y(i) + h/2*k1);
    k3 = f(t(i) + h/2, y(i) + h/2*k2);
    k4 = f(t(i+1), y(i) + h*k3);
    k = [k1 k2 k3 k4];
    y(i+1) = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);    
end
end