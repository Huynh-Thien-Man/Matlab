 clc;
clear all;
format long g;
a = 0;
b = 1;
% y'' - 2y' + 2y = exp(2t)*sin(t)
fy = @(t,y,z) z;
fz = @(t,y,z) exp(2*t)*sin(t) +2*z-2*y;
t0 = 0;
y0 = -0.4;
z0 = -0.6;
h = 0.1;
t = a:h:b;
u1 =  0.2.*exp(2.*t).*(sin(t)-2.*cos(t)); % u1 = y
u2 =  0.2.*exp(2.*t).*(4.*sin(t)-3.*cos(t)); %u2 = y'
[y z] = second_order1(a,b,fy,fz,t0,y0,z0,h,4);
A = [u1' y u2' z abs(u1'-y) abs(u2'-z)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code draw solution and norm error
for N = 2:10
    h = (b-a)/N;
    t = a:h:b;
    [y1 z1] = second_order1(a,b,fy,fz,t0,y0,z0,h,1);
    [y2 z2] = second_order1(a,b,fy,fz,t0,y0,z0,h,2);
    [y3 z3] = second_order1(a,b,fy,fz,t0,y0,z0,h,3);
    [y4 z4] = second_order1(a,b,fy,fz,t0,y0,z0,h,4);
    u1 =  0.2.*exp(2.*t).*(sin(t)-2.*cos(t));
    u2 =  0.2.*exp(2.*t).*(4.*sin(t)-3.*cos(t));
    
    ey1(N-1) = norm(u1'-y1,2);
    ey2(N-1) = norm(u1'-y2,2);
    ey3(N-1) = norm(u1'-y3,2);
    ey4(N-1) = norm(u1'-y4,2);
    
    ez1(N-1) = norm(u2'-z1,2);
    ez2(N-1) = norm(u2'-z2,2);
    ez3(N-1) = norm(u2'-z3,2);
    ez4(N-1) = norm(u2'-z4,2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n1 = 2:10;
plot(n1,ey1,n1,ey2,n1,ey3,n1,ey4)
title('Norm Error of w1 of Methods')
legend('Euler','RK2','RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(n1,ey3,n1,ey4)
title('Norm Error of w1 of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(n1,ez1,n1,ez2,n1,ez3,n1,ez4)
grid on;
title('Norm Error of w2 of Methods')
legend('Euler','RK2','RK4','Adam')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(n1,ez3,n1,ez4)
title('Norm Error of w2 of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(t,y1,t,y2,t,y3,t,y4,t,u1)
grid on;
legend('Euler','RK2','RK4','Adam','u1 = y(x)')
title('Approximation Solution of w1 of Methods')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(t,y3,t,y4,t,u1)
title('Approximation Solution of w1 of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(t,z1,t,z2,t,z3,t,z4,t,u2)
grid on;
legend('Euler','RK2','RK4','Adam','u2 = dy/dx')
title('Approximation Solution of w2 of Methods')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(t,z3,t,z4,t,u2)
title('Approximation Solution of w2 of Methods')
legend('RK4','Adam','u2 = dy/dx')
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%