format long;

%Padalec------------------------------------------------------------------------
masa = 105;
c = 1;
S = 1.2;
parametri = [masa,c,S];
zac = [40000; 0];
tk = 300;
n = 10000;

[visine, hitrosti, casi] = Padalec(parametri,zac,tk,n);

sum(hitrosti) / length(hitrosti);



%Diskretna veriznica------------------------------------------------------------
L_obesisce = [1 5];
D_obesisce = [6 2];
mase = [1, 2, 1, 2, 1, 2, 1, 2];
dolzine = [1, 1.5, 1, 1.5, 1, 1.5, 1, 1.5];
%zacetni priblizek
w0 = [-1 -10];

%izracuna krajisca prve verige
[X, Y] = Diskretna(w0, L_obesisce, D_obesisce, dolzine, mase);

%potencialna energija
potencialna = Potencial_diskretna(X, Y, mase);
potencialna;

%funkcija da bomo lahko iskali niclo 5 je zato ker premikamo 5 element in -180 ker iscemo kdaj bo energija 180
Premikanje = @(visina) Premik_vozla(5, visina, w0, X, Y, L_obesisce, D_obesisce, dolzine, mase) - 180;
%fzero(Premikanje, 0);


%Zvezna veriznica---------------------------------------------------------------
L = 12;
obesisceL = [0 5];
obesisceD = [5 3];

najnizja_tocka = Zvezna(obesisceL, obesisceD, L, 0.00001);
najnizja_tocka;

%iscemo obesisceD da bo najnizja tocka na x = 2.5

iskanje = @(za) Zvezna(obesisceL, obesisceD + [0, za], L, 0.000001)(1) - 2.5;
fzero(iskanje, 3);


%Brahistohrona------------------------------------------------------------------

zacetek = [1 5];
konec = [6, 2];


%izracunan cas potavanja
[cas_potovanja, k, theta] = Brahistohrona(zacetek, konec);
cas_potovanja;


%dve linearno odsekovni premici
cas_po_prvi = Premica(zacetek, [3 2]);

%hitrost po prvi premici
hitrost_premica = sqrt(2 * 9.81 * (-(2 - zacetek(2))));

%za drugo ne dobivamo hitrosti, ker je vodoravna izracunamo samo razdaljo
dolzina_druge = Dolzina_premice([3 2], konec);

%dobimo koliko casa potuje po drugi
cas_po_drugi = dolzina_druge / hitrost_premica;

%skupen cas da pride do konca
cas_po_prvi + cas_po_drugi;


%hitrost na koncu
hitrost = sqrt(2 * 9.81 * (-(konec(2) - zacetek(2))));


%funckija za klic fzero
F = @(w) Podaljsevanje_brahistohrone(w, theta, k, zacetek);
  
%dobimo za koliko je potrebno povecasi theto da bo cas potovanja 1.5
za_kok_pocevamo = fzero(F, 0.5); 

%povecamo theto in izracunamo nove koordinate
nova_theta = theta + za_kok_pocevamo;
nov_x = 1/2 * k^2 * (nova_theta - sin(nova_theta));
nov_y = -1/2 * k^2 * (1 - cos(nova_theta));

%imamo T2 do katerega smo podaljsali naso brahistohrono
nov_konec = [nov_x + zacetek(1) nov_y + zacetek(2)];

%2 norma nove tocke
norm(nov_konec);

%kdaj se kroglica prvic ustavi 
zacetek = [4 1];
konec = [8 0];

%izracunan cas potavanja
[cas_potovanja, k, theta] = Brahistohrona(zacetek, konec);

iskanje_Y =@(theta) -1/2 * k^2 * (1 - cos(theta)) + zacetek(2);

%kdaj bomo na isti visino kot kjer smo zaceli == se ustavi
kje_theta = fzero(iskanje_Y, 1);

%izracunamo pri katerem x je to
kje_X = 1/2 * k^2 * (kje_theta - sin(kje_theta)) + zacetek(1);

#se zrcalimo ker smo obrnili brahistohrono
koncni_X = zacetek(1) - abs(zacetek(1) - kje_X);


%T1(x, 5.1) in T2(5, 0.2)  kdj bo cas potovanja 1.5

kje_krajisce = @(x) Brahistohrona([x 5.1], [5 0.2])(1) - 1.5;
T1_x = fzero(kje_krajisce, -1);

%kasnen je y ko je x nekaj
zacetek = [T1_x 5.1];
konec = [5 0.2];
[cas_potovanja, k, theta] = Brahistohrona(zacetek, konec);
iskanje_X = @(theta) 1/2 * k^2 * (theta - sin(theta)) + zacetek(1) - ((3/4 * zacetek(1)) + (1/4 * konec(1)));
kje_theta = fzero(iskanje_X, 0);
iskan_Y = -1/2 * k^2 * (1 - cos(kje_theta)) + zacetek(2);

%po premici
cas_premice = Premica(zacetek, konec);


%iz (0, 0) po brahisohroni (5 + 94/100, -2) in potem po premici do (8, -5)
T1 = [0 0];
T2 = [5 + 94/100 -2];
T3 = [8 -5];

[cas_potovanja, k, theta] = Brahistohrona(T1, T2);

hitrost_na_T2 = sqrt(2 * 9.81 * (-(T2(2) - T1(2))));

cas_premica = Premica(T2, T3);

cas_potovanja + cas_premica











