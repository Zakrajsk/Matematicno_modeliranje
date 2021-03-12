function T_min = Zvezna(obesisceL,obesisceD,L,tol)
% function T_min = zvVeriznica(obesisceL,obesisceD,L,tol)
% Funkcija zvVeriznica narise zvezno veriznico in poisce njeno najnizjo tocko.
% Po knjigi Matematicno modeliranje (E. Zakrajsek).
% Vhod
% obesisceL, obesisceD: levo in desno obesisce veriznice, obesisceL=[a;A], obesisceD=[b;B]
% L:                    dolzina
% tol:                  toleranca pri iteraciji
%
% Izhod
% T_min:                najnizja tocka veriznice

a = obesisceL(1);
b = obesisceD(1);
A = obesisceL(2);
B = obesisceD(2);

% Jacobijeva iteracija za enacbo (15)
z = zvVeriznica_iteracijskaFun(a,A,b,B,L,1,tol);

% parametri v,u,C,D na koncu strani 4
v = atanh((B-A)/L)+z;
u = atanh((B-A)/L)-z;
C = (b-a)/(v-u);
D = (a*v-b*u)/(v-u);

% lambda, iz enacbe (5) ali (6)
lambda = A-C*cosh((a-D)/C);

% funkcija w, enacba (4)
w = @(x) lambda+C*cosh((x-D)/C);

%pri nekem posameznem x
%w(2)


%iskanje kdj seka premico y = X
%x = linspace(a,b,10000);
%for i = x
%  if abs(w(i) - i) < 0.001;
%    w(i)
%  end
%end

%iskanje dolzine vrvice
%kdaj = @(x) w(x) - 4;
%kje = fzero(kdaj, 0);
%dolzina = C * sinh(( b - D) / C) - C * sinh((kje - D) / C)


% graf veriznice
%plot(x,w(x),'b','LineWidth',0.5)
%hold on
%plot([a,b],[A,B],'ko','MarkerSize',5,'MarkerFaceColor','r');

% najnizja tocka, iz (4), ko je cosh(0) = 1
T_min = [D; lambda+C];
%plot(T_min(1),T_min(2),'ko','MarkerSize',5,'MarkerFaceColor','g');
%grid on;
%hold off
end


function z = zvVeriznica_iteracijskaFun(a,A,b,B,L,z0,tol)
% function z = zvVeriznica_iteracijskaFun(T1,T2,l,z0,tol)
% Iteracijska funkcija zvVeriznica_iteracijskaFun resi enacbo z=asinh(ro*z)
% za zvezno veriznico.
% 
% Vhod
% [a;A]:    levo obesisce
% [b;B]:    desno obesisce
% L:        dolzina veriznice
% z0:       zacetni priblizek
% tol:      toleranca pri ustavitvi iteracije
%
% Izhod
% z:        numericna resitev enacbe z=asinh(ro*z)
%

ro = L/(b-a)*sqrt(1-((B-A)/L)^2);
razlika = Inf;

while razlika>tol
    z = asinh(ro*z0);
    razlika = abs(z-z0);
    z0 = z;
end
end