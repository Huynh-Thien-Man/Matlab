clc;
clear all;
format long g;
% Range of x
a = 0;
b = 1;
% Step size
h = 0.1;
% Range of Exact Solution
c = 0:0.1:1;
% Initial values
x0 = 0;
y0 = 0;
%% Define f(x,y) 
f = @(x,y) x - y^2
A1 = onestepmethod(f,a,b,x0,y0,h,1)'
A2 = onestepmethod(f,a,b,x0,y0,h,2)'
A3 = onestepmethod(f,a,b,x0,y0,h,3)'
Pre_Cor = predictor_corrector(f,a,b,x0,y0,h)
Pre_Cor_Other = other_predictor_corrector(f,a,b,x0,y0,h)
[Xe,Yexact] = ode45(f,c,y0);
YexactSol=[,Yexact];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code draw solution and norm error
for N = 2:10
    h = (b-a)/N;
    c = 0:h:1;
    [Xe,Yexact] = ode45(f,c,y0);
    YexactSol=[,Yexact];
    A1 = onestepmethod(f,a,b,x0,y0,h,1)';
    A2 = onestepmethod(f,a,b,x0,y0,h,2)';
    A3 = onestepmethod(f,a,b,x0,y0,h,3)';
    Pre_Cor = predictor_corrector(f,a,b,x0,y0,h);
    Pre_Cor_Other = other_predictor_corrector(f,a,b,x0,y0,h);
    e1(N-1) = norm(YexactSol-A1,2);
    e2(N-1) = norm(YexactSol-A2,2);
    e3(N-1) = norm(YexactSol-A3,2);
    e4(N-1) = norm(YexactSol-Pre_Cor,2);
    e5(N-1) = norm(YexactSol-Pre_Cor_Other,2);
end
n1 = 2:10;
plot(n1,e1,n1,e2,n1,e3,n1,e4,n1,e5)
title('Norm Error of Methods')
legend('Euler','RK2','RK4','Adam','Milne')
grid on;
%%%%%%%%%%%%%%%%%
figure
plot(n1,e3,n1,e4)
title('Norm Error of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
figure
plot(c,YexactSol)
grid on;
legend('Exact Solution')
title('Exact Solution of y(x)')
%%%%%%%%%%%%%%%%%
figure
plot(c,A1,c,A2,c,A3,c,Pre_Cor,c,Pre_Cor_Other)
grid on;
legend('Euler','RK2','RK4','Adam','Milne')
title('Approximation Solution of Methods')
%%%%%%%%%%%%%%%%%
figure
plot(c,A3,c,Pre_Cor)
title('Approximation Solution of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%