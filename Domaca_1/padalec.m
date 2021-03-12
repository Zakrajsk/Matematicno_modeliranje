function [y,v,t] = padalec(parametri,zac,tk,n)
% function [y,v,t] = padalec(parametri,zac,tk,n)
% 
% Simulacija vertikalnega padanja padalca v odvisnosti od zacetne hitrosti
% in zracnega upora.
%
% Vhod:
% parametri = [m,c,S], m je masa, c je koeficient upora (prib. 1 za
% obicajen skok in skakalca), S presek padalca pravokotno na smer padanja
% zac = [y0;v0] sta zacetna visina in zacetna hitrost
% tk je koncni cas, do katerega gledamo padanje (pred odprtjem padala!!!)
% n je stevilo enakomerno razporejenih casovnih trenutkov opazovanja
%
% Za gostoto zraka privzamemo ro=1.3 kg/m^3, tezni pospesek g=9.8 m/s^2
%
% Izhod:
% y so visine padalca ob casih t (vektor dolzine n)
% v so hitrosti padalca ob casih t (vektor dolzine n)
% t je vektor casovnih trenutkov

t = linspace(0,tk,n);
dY = @(t,Y) diferencialniSistem(t,Y,parametri);
[~,Yres] = ode45(dY,t,zac);

% visine in hitrosti padalca
y = Yres(:,1);
v = Yres(:,2);

function dY = diferencialniSistem(t,Y,parametri)
% function dY = diferencialniSistem(t,Y,parametri)
% 
% Opisuje sistem dif. enacb za padalca pri navpicnem padu.
%
% Vhod:
% t je cas, Y = [y1;y2]
% Prva komponenta Y(1) predstavlja pozicijo.
% Druga komponenta Y(2) predstavlja hitrost.
% parametri = [m,c,S]
% 
% Izhod:
% dY je sistem NDE, vrnemo desno stran sistema dY = F(t,Y)

ro = 1.225;
g = 9.8;
m = parametri(1);
c = parametri(2);
S = parametri(3);

K = 1/2*ro*c*S;

% Opomba: Ce je hitrost pozitivna, je sila upora negativna in obratno.
%         Zato namesto y(2).^2 uporabimo -abs(y(2)).*y(2).
dY = [Y(2); -g-K/m*abs(Y(2)).*Y(2)];
end

end



