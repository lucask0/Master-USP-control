% Lista 2 - PTC5611
% Exerc�cio 1
% Autor: Bruno Peixoto

clear all;
close all;
clc;

s = tf('s');

% Planta
G = 1/((s+1)*(s+3));

% Criterios de projeto

% Tempo de acomodacao 2% [s]
ts = 3;

% Sobressinal []
M = 0.15;

zeta = zeta_overshoot(M);
wn = 3.9/(zeta*ts);

% Op��o de projeto
Ts = 1;

K = 2;
a = 1;
C = K*(s+a)/s;

Cz = c2d(C, Ts, 'tustin');
Cz.variable = 'z^-1';

% Parametros do controlador
params.b0 = Cz.num{1}(1);
params.b1 = Cz.num{1}(2);

params.a0 = Cz.den{1}(1);
params.a1 = Cz.den{1}(2);

mdlnome = 'ex1sim';
open_system(mdlnome);
save_system;
set_param(mdlnome, 'SaveOutput', 'on');
simOuta = sim(mdlnome, 'StopTime', num2str(tf), ...
                       'SrcWorkspace', 'current', ...
                       'AbsTol', '1e-10', ...
                       'RelTol', '1e-10');
close_system;

sgrid;

% Condi��es para zeta
m = tan(acos(zeta));
sigma = -3.9/ts;

dy = 0.001;

scaler = 1.5;
ymax = -scaler*m*sigma;
intercep = m*sigma;

rlocus(G*C/(1 + G*C));
hold on;
sgrid
hold on;

cond_zeta_x = sigma:-0.01:m*sigma;
cond_zeta_ym = m*cond_zeta_x;
cond_zeta_yp = -m*cond_zeta_x; 

plot(cond_zeta_x, cond_zeta_ym, 'k');
hold on;
plot(cond_zeta_x, cond_zeta_yp, 'k');
hold on;

sigmay = intercep:dy:-intercep;
sigmax = sigma*ones(size(sigmay));

plot(sigmax, sigmay, 'k');
hold off

title('Lugar das ra\''izes do sistema compensado', 'interpreter', 'latex');
hxfig = xlabel('', 'interpreter', 'latex');
hyfig = ylabel(' ', 'interpreter', 'latex');

hxfig.String = '$\sigma$';
hyfig.String = '$\omega$';

axis([m*sigma 0 -ymax ymax]);

set(gcf, 'units', 'normalized');
set(gcf, 'Position', [0.1487 0.1100 0.7563 0.7817]);

saveas(gcf, '../images/ex1_rlocus.png');
print(gcf,'../images/ex1_rlocus.pdf','-dpdf','-r0')
% close;