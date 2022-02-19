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
y0 = 2;
%% Define f(x,y) 
f = @(x,y) -5*y + 6*exp(x)

%% Exact Solution
Yexact = exp(c) + exp(-5*c);
YexactSol = Yexact';

%% Predictor-Corrector of Adam-Bash-Moul 
Pre_Cor = predictor_corrector(f,a,b,x0,y0,h)%Predictor-Corrector of Adam-Bash-Moul 
A = [YexactSol Pre_Cor abs(YexactSol-Pre_Cor)]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Code draw solution and norm error
for N = 2:10
    h = (b-a)/N;
    c = 0:h:1;
    Yexact = exp(c) + exp(-5*c);
    YexactSol = Yexact';
    A1 = onestepmethod(f,a,b,x0,y0,h,1)';
    A2 = onestepmethod(f,a,b,x0,y0,h,2)';
    A3 = onestepmethod(f,a,b,x0,y0,h,3)';
    Pre_Cor = predictor_corrector(f,a,b,x0,y0,h);
    e1(N-1) = norm(YexactSol-A1,2);
    e2(N-1) = norm(YexactSol-A2,2);
    e3(N-1) = norm(YexactSol-A3,2);
    e4(N-1) = norm(YexactSol-Pre_Cor,2);
end
n1 = 2:10;
plot(n1,e1,n1,e2,n1,e3,n1,e4)
title('Norm Error of Methods')
legend('Euler','RK2','RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%
figure
plot(n1,e3,n1,e4)
title('Norm Error of Methods')
legend('RK4','Adam')
grid on;
%%%%%%%%%%%%%%%%%
figure
plot(c,A1,c,A2,c,A3,c,Pre_Cor,c,YexactSol)
grid on;
legend('Euler','RK2','RK4','Adam','Yexact')
title('Approximation Solution of Methods')
%%%%%%%%%%%%%%%%%
figure
plot(c,A3,c,Pre_Cor,c,YexactSol)
title('Approximation Solution of Methods')
legend('RK4','Adam','YexactSol')
grid on;
%%%%%%%%%%%%%%%%%