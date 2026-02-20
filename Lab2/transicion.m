%    Calcula la transiciòn al estado estacionario del Modelo de 
%    Crecimiento Neoclásico. 
%
%    El algoritmo asume que en T periodos el modelo converge a su 
%    estado estacionario. Requiere una función externa con las
%    condiciones de primer orden del problema (func_cpo.m).
%
%    Carlos Urrutia, 2025

clear all
clc

%%   Define los parámetros del modelo y calcula el capital de estado 
%    estado estacionario

global beta A alpha delta k0 T

beta    = 0.95;
A       = 1;
alpha   = 0.35;
delta   = 0.05;

kss = (A*alpha/(1/beta-(1-delta)))^(1/(1-alpha))
css = (A*kss^alpha-delta*kss)

%% Calcula la transión al estado estacionario

T = 100;        
k0 = kss/2;     

ct0 = ones(1,T)*(A*k0^alpha-delta*k0);    % Inicializa solución
kt0 = k0*ones(1,T);    

x0 = [ct0;kt0];

xt = fsolve('func_cpo',x0); %xt es una matrix de 2x100 porque mi matriz de ecuaciones (error) es una matrix de 2x100

ct = xt(1,:);
kt = xt(2,:);

%% Grafica la trayectoria óptima del capital

figure(1)

plot(1:T,kt(1:T),'b',1:T,kss*ones(1,T),'r--','LineWidth',2)
title('Capital')

%% Grafica las trayectorias óptimas de otras variables

yt = A*kt(1:T-1).^alpha; %y=AK^alpha
it = kt(2:T)-(1-delta)*kt(1:T-1); %k(t+1) - (1-delta) k(t) -> it(1) = k(2) - (1-delta)k(1) -> it(T)= kt(T) - (1-delta)K(T-1)
ct = yt-it;

figure(2)

subplot(3,1,1)
plot(1:T-1,yt,'b','LineWidth',2);
title('Producto')

subplot(3,1,2)
plot(1:T-1,it,'b','LineWidth',2);
title('Inversión')

subplot(3,1,3)
plot(1:T-1,ct,'b','LineWidth',2);
title('Consumo')

