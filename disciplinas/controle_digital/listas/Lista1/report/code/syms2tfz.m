% Convert Symbolic Transfer Function to ZPK Transfer Function
% Crystal Nassouri 2009
% Allows for substitution/manipulation that can only be done with syms
% 
% Ex: Gs = syms2tf(G)
% Where G is a symbolic equation and Gs is a zpk transfer function
% Source: https://www.mathworks.com/matlabcentral/fileexchange/27302-syms-to-tf-conversion

function[ans] = syms2tfz(G, Ts)
[symNum,symDen] = numden(G); %Get num and den of Symbolic TF
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial

ans = tf(TFnum,TFden, Ts);
