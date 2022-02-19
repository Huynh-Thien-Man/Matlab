clc;
clear all;
format long g;
a = 0; %t0 = 0
b = 2; %tn = 2
L = 2;
g = 32.17;
h = 0.1;
t = 0:0.1:2;
%%a) z"+(g/L)*sin(y) = 0
fy = @(t,y,z) z
fz = @(t,y,z) (-g/L)*sin(y)
t0 = a;
y0 = pi/6;
z0 = 0;
[y1 z1] = second_order1(a,b,fy,fz,t0,y0,z0,h,4);
A = [t' y1 z1]

%%b) z"+(g/L)*y = 0
fy = @(t,y,z) z
fz = @(t,y,z) (-g/L)*y
t0 = a;
y0 = pi/6;
z0 = 0;
[y2 z2] = second_order1(a,b,fy,fz,t0,y0,z0,h,4);
B = [t' y2 z2]