clc;
clear all;
format short g;
a = 0;
b = 60; % in 60 minutes
% Unmixed coffee
x0 = 0;
h = 1; %per minute
y0 = 90;
r = 0.001*60;       % cooling rate
e = 20;             % environment degree
f = @(t,y) -r*(y - e);   % f'(t) is the law of refrigeration % t is cooling time
T = 0:1:60;
T = T';
Y = predictor_corrector(f,a,b,x0,y0,h);
A = [T Y];
for i = 1:length(Y)
  for i = 1 : length(T)
    if Y(i) <= 60
      ans = [T(i) Y(i)];
      break
    end
  end
end
ans;
plot(T,Y,T(i),Y(i),'o')
grid on;
title('The degree plot of Coffee')
legend('y(t)','Degree could be drink')
fprintf('Your coffee was able to drink after %d minutes with temperature is %d degrees Celsius\n',ans)

%%Coffee mixed cream immediately
v1 = 8; % Volume of coffee follow ounce
v2 = 1; % Volume of cream follow ounce
y1 = 90; % the degree of coffee 
y2 = 20; % the degree of cream
degreenew = (v1.*y1 + v2.*y2)./(v1+v2);
T = 0:1:60;
Y = predictor_corrector(f,a,b,x0,degreenew,h);
B = [T' Y];
for i = 1:length(Y)
 for i = 1 : length(T)
   if Y(i) <= 60 
     ans1 = [T(i) Y(i)];
     break
   end
 end
end
ans1;
figure
plot(T,Y,T(i),Y(i),'o')
grid on;
title('The degree plot of Coffee mixed cream immediately')
legend('y(t)','Degree could be drink')
fprintf('Your coffee was able to drink after %d minutes with temperature is %d degrees Celsius\n',ans1)

%%The degree of coffee cooled to 60 degrees Celsius and then mixed with cream 
v1 = 8; % Volume of coffee follow ounce
v2 = 1; % Volume of cream follow ounce
y1 = 90; % the degree of coffee 
y2 = 20; % the degree of cream
T = 0:1:60;
Y = predictor_corrector(f,a,b,x0,y0,h);
C = [T' Y];
for i = 1:length(Y)
   for i = 1 : length(T)
   if Y(i) <= 60
     ans2 = [T(i) Y(i)];
     break
   end
 end
end
ans2;
degreenew2 = (v1.*Y(i) + v2.*y2)./(v1+v2);
Z = predictor_corrector(f,a,b,x0,degreenew2,h);
figure
plot(T,Y,T(i),Y(i),'o',T(1),degreenew2,'o',T,Z)
grid on;
title('The degree plot of Coffee mixed cream after cooling')
legend('y(t) unmixed cream','Degree could be drink','New degree after mixed cream','y(t) mixed cream')
fprintf('After %d minutes, the degree of coffee is %d ,and then mixed with cream has the new dregree is %d degrees Celsius\n',ans2,degreenew2)