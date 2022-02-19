function y = other_predictor_corrector(f,a,b,t0,y0,h)
x(1)=t0;
y(1)=y0;
n = (b-a)/h;
for i = 1:n
    t(i+1,1) = t0 + i*h;
    k1 = f(t(i),y(i));

    k2 = f(t(i) + h/2, y(i) + h/2*k1);

    k3 = f(t(i) + h/2, y(i) + h/2*k2);

    k4 = f(t(i+1), y(i) + h*k3);

    y(i+1,1) = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);    
end
        for i = 5:n
          t(i+1,1) = t0 + i*h;
          y(i+1,1)= y(i-2) + (4*h/3)*(2*f(t(i+1),y(i+1)) - f(t(i-1),y(i-1)) + 2*f(t(i),y(i)));
          p=y;
          y(i+1,1) = y(i) +(h/3)*(f(t(i-1),y(i-1))+4*f(t(i),y(i)) + f(t(i+1),p(i+1)));
        end