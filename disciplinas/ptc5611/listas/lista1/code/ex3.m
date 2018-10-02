clear all; 
close all; 
clc;

% [s]
Ts = 0.1;

% [s^-1]
s0 = 0.01;

z0 = exp(Ts*s0);

% [rad/s]
ws = 2*pi/Ts;

% Funcoes de transferencia 
G = tf(1, [1,0]);
Ga = ((1 - z0)/s0)*tf(1, [1, z0], Ts, 'Variable', 'z^-1');
Gb = ((1 - z0)/(2*s0))*tf([1 -1], [1 z0], Ts, 'Variable', 'z^-1');

hfig = figure('units','normalized','outerposition',[0 0 1 1]);
set(hfig, 'defaultLegendInterpreter','latex');

bode(G);
hold on;
bode(Ga);
hold on;
bode(Gb);
hold off;

legend('$\frac{1}{s}$', 'Estritamente própria', 'Biprópria', 'fontsize', '20');
title('Diagrama de bode de 1/s', 'interpreter', 'latex');
xlabel('Frequência de entrada', 'interpreter', 'latex');

xlim([1, 1.5*ws/2]);
saveas(hfig, '../../report/images/ex3.png');
saveas(hfig, '../../report/images/ex3.eps');