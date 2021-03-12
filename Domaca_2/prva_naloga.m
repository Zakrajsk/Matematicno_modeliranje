format long;

function z = F_uv(w, L_obesisce, D_obesisce, dolzine, Mi)
  %formule
  xi_i = @(i, u, v) dolzine(i) / (sqrt(1 + (v - u * sum(Mi(1:i)))^2));
  eta_i = @(i, u, v) xi_i(i, u, v) * (v - u * sum(Mi(1:i)));
  n = length(dolzine) - 1;
  
  izrac_xi = zeros(1, n + 1) ;
  izrac_etai = zeros(1, n + 1);
  
  %napolni tabele xijev in etaijev
  for i = 1 : n + 1
    izrac_xi(i) = xi_i(i, w(1), w(2));
    izrac_etai(i) = eta_i(i, w(1), w(2));
  end
  
  %funkciji za iskanje nicle
  U = @(w) sum(izrac_xi) - (D_obesisce(1) - L_obesisce(1));
  V = @(w) sum(izrac_etai) - (D_obesisce(2) - L_obesisce(2));
  
  %kar vrnemo in s tem iscemo 0
  z = [U(w), V(w)];
end


function [X, Y] = Vrni_krajisca(w0, L_obesisce, D_obesisce, dolzine, mase)
  %vrne vsa krajisca od veriznice s podatki
  n = length(dolzine) - 1;

  %vmesne vsote
  Mi = zeros(1, n + 1);
  for i = 1 : n
    Mi(i + 1) = (mase(i) + mase(i + 1)) / 2;
  end
  
  %funkcija za fsolve
  F = @(w) F_uv(w, L_obesisce, D_obesisce, dolzine, Mi);

  %zacetni priblizek
  w0 = [-1 -10];
  %options = optimoptions('fsolve','Display','iter', 'FunctionTolerance', 1e-16);
  [nicelni_w,Fopt] = fsolve(F,w0);
  
  %xi in eta formule
  xi_i = @(i, u, v) dolzine(i) / (sqrt(1 + (v - u * sum(Mi(1:i)))^2));
  eta_i = @(i, u, v) xi_i(i, u, v) * (v - u * sum(Mi(1:i)));

  izrac_xi = zeros(1, n + 1) ;
  izrac_etai = zeros(1, n + 1);

  %izracunamo vse xi in etai
  for i = 1 : n + 1
    izrac_xi(i) = xi_i(i, nicelni_w(1), nicelni_w(2));
    izrac_etai(i) = eta_i(i, nicelni_w(1), nicelni_w(2));
  end

  %naredimo tabeli vozlisc
  X = zeros(1, n + 2);
  Y = zeros(1, n + 2);
  %dodamo notri se prvo zacetno vozlisce
  X(1) = L_obesisce(1);
  Y(1) = L_obesisce(2);

  %vstavimo se vsa naslednja po izracunu
  for i = 1 : n + 1
    X(i + 1) = L_obesisce(1) + sum(izrac_xi(1:i));
    Y(i + 1) = L_obesisce(2) + sum(izrac_etai(1:i));
  end
end


function rez = Potencialna(X, Y, mase)
  %izracuna potenicalno energijo za neko veriznico
  gravitacija = 9.81;
  rez = 0;
  
  n = length(mase) - 1;

  for i = 1 : n + 1
    rez = rez + (mase(i) * gravitacija * ((Y(i) + Y(i + 1)) / 2));
  end
end

%zacetni podatki
L_obesisce = [1 5];
D_obesisce = [6 2];
mase = [1, 2, 1, 2, 1, 2, 1, 2];
dolzine = [1, 1.5, 1, 1.5, 1, 1.5, 1, 1.5];

%zacetni priblizek
w0 = [-1 -1];

%izracuna krajisca prve verige
[X, Y] = Vrni_krajisca(w0, L_obesisce, D_obesisce, dolzine, mase);
%aritmeticna sredina
mean(X)

%------------------------------------------

%potencialna energija
potencialna = Potencialna(X, Y, mase);
potencialna

%------------------------------------------

%spreminjanje veriznice
%mase = [0.5, 0.5, 1, 1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1, 1, 0.5, 0.5, 1, 1];
%dolzine = [0.5, 0.5, 0.75, 0.75, 0.5, 0.5, 0.75, 0.75, 0.5, 0.5, 0.75, 0.75, 0.5, 0.5, 0.75, 0.75];

%za spremenjene izracunamo novo veriznico
[X, Y] = Vrni_krajisca(w0, L_obesisce, D_obesisce, dolzine, mase);;
min(Y)


%------------------------------------------

%potencialna > 180

function potencialna = Premik_vozla(st_dvigajocega, za_kolk, w0, X, Y, L_obesisce, D_obesisce, dolzine, mase)
  %razdeli eno veriznico na dve glede na to kateri element zdvigujemo
  
  %mase obeh in dolzine rezane v pravilnih velikostih
  L_mase = mase(1:st_dvigajocega - 1);
  D_mase = mase(st_dvigajocega:length(mase));
  
  L_dolzine = dolzine(1:st_dvigajocega - 1);
  D_dolzine = dolzine(st_dvigajocega:length(dolzine));
  
  %premaknemo tisto vozlisce za nekaj
  premikamo = [X(st_dvigajocega), Y(st_dvigajocega)];
  premikamo(2) = premikamo(2) + za_kolk;
  %izracunamo obe veriznice levo in desno od dvigajocega
  [L_X, L_Y] = Vrni_krajisca(w0, L_obesisce, premikamo, L_dolzine, L_mase);
  [D_X, D_Y] = Vrni_krajisca(w0, premikamo, D_obesisce, D_dolzine, D_mase);

  L_pote = Potencialna(L_X, L_Y, L_mase);
  D_pote = Potencialna(D_X, D_Y, D_mase);

  %sestejemo obe potencialni energiji
  potencialna = L_pote + D_pote;
end

%funkcija da bomo lahko iskali niclo 5 je zato ker premikamo 5 element in -180 ker iscemo kdaj bo energija 180
Premikanje = @(visina) Premik_vozla(5, visina, w0, X, Y, L_obesisce, D_obesisce, dolzine, mase) - 180;

fzero(Premikanje, 0)

%------------------------------------------

%Dvigovanje podlage na 0
D_obesisce = [8.5 0];

%se enkrat izracunamo z novim obesiscem
[X, Y] = Vrni_krajisca(w0, L_obesisce, D_obesisce, dolzine, mase);

%Najdemo katera vozlisca se bojo naslonila tistih ne gledamo 
do_kam = 1;
while Y(do_kam) > 0
  do_kam = do_kam + 1;
end

do_kam;

%spremenimo da izracunamo novo veriznico

levi_x = X(do_kam);

%od konca odstejemo vsa in predpostavimo da lezijo na isti crti (0) tako dobimo kje je tisto za vpenjati
premik_obesisca = D_obesisce(1) - sum(dolzine(do_kam:length(dolzine)));
novo_koncno_obesisce = [premik_obesisca, 0];

%tudi mase in dolzine skrcimo, ne rabimo tistih, ki lezijo na tleh
nove_mase = mase(1:do_kam - 1);
nove_dolzine = dolzine(1:do_kam - 1);

%izracunamo nova krajisca, samo tista ki so v zraku
[X_leva, Y_leva] = Vrni_krajisca(w0, L_obesisce, novo_koncno_obesisce, nove_dolzine, nove_mase);

%izracunamo potencialno samo vseh teh vozlisc
potencialna = Potencialna(X_leva, Y_leva, nove_mase);
potencialna



 


