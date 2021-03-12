format long;
function [opt_theta, k] = Optimalna_tk(b, B)
  %Izracuna optimalno theta in koeficient k
  
  g = @(theta) 1 - cos(theta) + (B / b) * (theta - sin(theta));
  
  %najdemo pri kateri theti je g == 0
  opt_theta = fzero(g, pi);
  
  %izracunamo k po formuli
  k = sqrt(2 * b / (opt_theta - sin(opt_theta))); 
end

function [cas, k, theta] = Brahi(zacetek, konec)
  %izracuna cas potovanja po krivulji vrne prav tako theto in k
  
  %premaknemo koordinate
  konec = konec - zacetek;
  zacetek = [0 0];
  
  gravitacija = 9.81;
  
  %poklicemo funkcijo, ki nam izracuna optimalno theto in koeficient k
  [theta, k] = Optimalna_tk(konec(1), konec(2));
  
  %izracunamo cas po formuli
  cas = k / sqrt(2 * gravitacija) * theta;
end

function cas = Premi(zacetek, konec)
  %cas potovanja po premici 
  
  %premaknemo koordinate
  konec = konec - zacetek;
  zacetek = [0 0];
  gravitacija = 9.81;
  
  %izracunamo cas po formuli
  cas = sqrt(2 * (konec(1)^2 + konec(2)^2) / (gravitacija * -konec(2)));
end

function dolzina = Dolzina_premice(zacetek, konec)
  %evklidska dolzina premice
  dolzina = sqrt((konec(1) - zacetek(1))^2 + (konec(2) - zacetek(2))^2);
end


zacetek = [1 5];
konec = [6, 2];


%izracunan cas potavanja
[cas_potovanja, k, theta] = Brahi(zacetek, konec);
cas_potovanja

%---------------------------------

%dve linearno odsekovni premici
cas_po_prvi = Premi(zacetek, [3 2]);

%hitrost po prvi premici
hitrost_premica = sqrt(2 * 9.81 * (-(2 - zacetek(2))));


%za drugo ne dobivamo hitrosti, ker je vodoravna izracunamo samo razdaljo
dolzina_druge = Dolzina_premice([3 2], konec);

%dobimo koliko casa potuje po drugi
cas_po_drugi = dolzina_druge / hitrost_premica;

%skupen cas da pride do konca
cas_po_prvi + cas_po_drugi

%----------------------------------

%hitrost na koncu
hitrost = sqrt(2 * 9.81 * (-(konec(2) - zacetek(2))))

%-----------------------------------

%najvecja hitrost
[cas_potovanja, k, theta] = Brahi(zacetek, konec);

%naredimo interval thet
int_theta = linspace(1, theta);

%izracunamo vse visine za vse thete
Y = -1/2 * k^2 * (1 - cos(int_theta));

%najvecja hitrost bo v najnizji tocki zato vzamemo min
najvecja_hitrost = sqrt(2 * 9.81 * (-min(Y)))

%-----------------------------------

%premikanje T
function cas_podaljsan = Podaljsevanje(povecava, theta, k, zacetek)
  %premikamo theto (podaljsujemo funkcijo) da ugotovimo kdaj bo cas potovanja enak 1.5
  %premikamo s pomocjo thete da ohranimo k
  
  naslednja_theta = theta + povecava;
  zad_x = 1/2 * k^2 * (naslednja_theta - sin(naslednja_theta));
  zad_y = -1/2 * k^2 * (1 - cos(naslednja_theta));

  %tukaj imamo nov konec po premiku thete 
  nov_konec = [0 0];
  nov_konec(1) = zad_x + zacetek(1);
  nov_konec(2) = zad_y + zacetek(2);

  %izracunamo novi cas potovanja
  [cas_potovanja, k, theta] = Brahi(zacetek, nov_konec);
  
  %-1.5 zato, ker iscemo z fzero in rabimo kdaj bo cas potovanja 1.5
  cas_podaljsan = cas_potovanja - 1.5;
end
 

%funckija za klic fzero
F = @(w) Podaljsevanje(w, theta, k, zacetek);
  
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
















