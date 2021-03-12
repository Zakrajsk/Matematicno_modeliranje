%konstante za spreminjat
format long

%parametri
teza = 105;
gostota_zraka = 1.225;
tezni_pospesek = 9.81;
povrsina_padalca = 1.2;
koef_upora = 1;

zacetna_visina = 40000;
zacetna_hitrost = 0;

cas_merjenja = 300;

%interval na kolkih casovnih tockah bomo gledali
interval_tock = linspace(0, cas_merjenja, 10000);

K = 1/2 * gostota_zraka * koef_upora * povrsina_padalca;

%sistem ki ga bomo resevali z ode45
sistem_NDE = @(t, y)[y(2); -tezni_pospesek - K / teza * abs(y(2)) .* y(2)];

[~, resitev] = ode45(sistem_NDE, interval_tock, [zacetna_visina, zacetna_hitrost]);

%v resitvi so zapisanje visine in hitrosti
visine = resitev(:,1);
hitrosti = resitev(:,2);

%izracunamo aritmeticno sredinoo
sum(hitrosti) / length(hitrosti)


radij_zemlje = 6371000;

%spremenimo kako se tezni pospesek spreminja z visino
funkcija_teznega = @(visina) tezni_pospesek * (radij_zemlje / (radij_zemlje + visina))^2;

%spremenimo NDE, da bo uposteval nov tezni pospesek pri vsaki visini
sistem_NDE = @(t, y)[y(2); -funkcija_teznega(y(1)) - K / teza * abs(y(2)) .* y(2)];

[~, resitev] = ode45(sistem_NDE, interval_tock, [zacetna_visina, zacetna_hitrost]);

visine = resitev(:, 1);

%izpisemo zadnjo, saj je tam koncna visina
visine(end)


%tabela za najmanjse kvadrate
na_visini = [0; 2000; 4000; 6000; 8000; 10000; 15000; 20000; 25000; 30000; 40000];
je_gostota = [1.225; 1.007; 0.8194; 0.6601; 0.5258; 0.4135; 0.1948; 0.08891; 0.04008; 0.01841; 0.003996];

%naredimo matriko, kjer upostevamo enacbo da bomo dobili koeficiente
kvadrati = [ones(length(na_visini), 1), ((na_visini - 40000)/40000).^2, ((na_visini - 40000)/40000).^4];

%delimo z leve in dobimo koeficiente
naj_kvadrati = kvadrati \ je_gostota;

%naredimo novo funkcijo za gostoto z izracunanimi koeficienti
funkcija_gostote = @(visina) naj_kvadrati(1) + naj_kvadrati(2) * ((visina - 40000) / 40000)^2 + naj_kvadrati(3) * ((visina - 40000) / 40000)^4;

%spremenimo K tako da se uporabi nova funkcija
K = @(visina) 1/2 * funkcija_gostote(visina) * koef_upora * povrsina_padalca;

%spremenjen sistem NDE
sistem_NDE = @(t, y)[y(2); -funkcija_teznega(y(1)) - K(y(1)) / teza * abs(y(2)) .* y(2)];

[~, resitev] = ode45(sistem_NDE, interval_tock, [zacetna_visina, zacetna_hitrost]);

%rabimo samo visino in izpisemo ponovno zadnjo
visine = resitev(:, 1);

visine(end)


%cas merjenja se spremeni
cas_merjenja = 30;
interval_tock = linspace(0, cas_merjenja, 10000);

[~, resitev] = ode45(sistem_NDE, interval_tock, [zacetna_visina, zacetna_hitrost]);

%kaksna bo hitrost brez odriva
brez_odriva = resitev(:,2)(end);

zacetna_hitrost = -3;

[~, resitev] = ode45(sistem_NDE, interval_tock, [zacetna_visina, zacetna_hitrost]);

%kaksna bo hitrost z odrivom
z_odrivom = resitev(:,2)(end);

%razlika med njima
z_odrivom - brez_odriva


%vrnemo zacetno hitrost na 0 ker delamo ponovno brez odriva
zacetna_hitrost = 0;

%za boljsi priblizek spreminjamo te parametre
cas_merjenja = 34;
interval_tock = linspace(0, cas_merjenja, 10000);

%tam k je treba bolj natancno dodamo veliko tock
za_natancno = linspace(34, 35, 1000000);

%sestavimo skupaj interval
skupej_interval = [interval_tock za_natancno];

[~, resitev] = ode45(sistem_NDE, skupej_interval, [zacetna_visina, zacetna_hitrost]);

%dobimo visine in hitrosti
visine = resitev(:,1);
hitrosti = resitev(:,2);

%ne ravno optimalna metoda ampak dela :D 
%premikamo se po hitrostih in iscemo kdaj prvic presežemo 300m/s
for i = 1 : length(skupej_interval)
  if hitrosti(i) <= -300
    %izpise cas s katerim dobimo toliko hitrosti
    skupej_interval(i)
    break
  end
end










