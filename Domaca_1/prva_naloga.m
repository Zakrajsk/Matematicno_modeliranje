format long
f = @(x, y) sin(cos(x + y)) + e^(-(x - 1)^2 - (y - 1)^2);

fx = @(x, y) -2*e^(-(x - 1)^2 - (y - 1)^2) * (x - 1) - cos(cos(x + y)) * sin(x + y);
fy = @(x, y) -2*e^(-(x - 1)^2 - (y - 1)^2) * (y - 1) - cos(cos(x + y)) * sin(x + y);

xi = linspace(0, 5);
yj = linspace(0, 5);

najvecja = -inf;
naj_x = -inf;
naj_y = -inf;

stevec_neg = 0;
vsota_neg = 0;

for i = 1 : 100
  for j= 1 : 100
    vrednost = f(xi(i), yj(j));
    if vrednost > najvecja
      najvecja = vrednost;
      naj_x = xi(i);
      naj_y = yj(j);
    end
    
    if vrednost < 0
      stevec_neg = stevec_neg + 1;
      vsota_neg = vsota_neg + vrednost;
    end
  end
end

#2 norma najvecjega x in y
disp("\n 2 norma x in y kjer je f najvecja")
norm([naj_x, naj_y])

#povp negativnih
disp("\n povprecje negativnih vrednost f")
vsota_neg / stevec_neg
#lahko tudi mean(vektor vseh)


#lahko bi ze prej gledali tudi za najvecjo razdaljo samo bi blo potreben if
#ki bi se vsakic preverjal

naj_razlika = -inf;

for i = 1 : 99
  for j = 1 : 100
    vrednost = f(xi(i), yj(j));
    prejsna = f(xi(i + 1), yj(j));
    trenutna_razlika = abs(vrednost - prejsna);
    if trenutna_razlika > naj_razlika
      naj_razlika = trenutna_razlika;
    end
 end
end

disp("\n 2 Norma najveje razlike med dvema vrstama")
norm(naj_razlika)


%za resevanje pomoc na strani:
%https://stromar.si/assets/Uploads/9/ma3-u-1112-jpds.pdf na strani 3
x = 3;
y = 4;

%normalo potem se delimo da dobimo enotsko
normala = [-fx(x, y), -fy(x, y), 1] / sqrt(fx(x, y)^2 + fy(x, y)^2 + 1);

disp("\n 1 komponenta enotske normale je")
normala(1)

%pretvorimo odvoda v vektroske enacbe za uporabo fsolve (lahko bi ze zgoraj,
%vendar je ze vse ostalo narejno tako da bomo tukaj samo redefinirali fx in fy

fx = @(x) -2*e^(-(x(1) - 1)^2 - (x(2) - 1)^2) * (x(1) - 1) - cos(cos(x(1) + x(2))) * sin(x(1) + x(2));
fy = @(x) -2*e^(-(x(1) - 1)^2 - (x(2) - 1)^2) * (x(2) - 1) - cos(cos(x(1) + x(2))) * sin(x(1) + x(2));

x0 = [0.4, 0.4];

nicla = fsolve(@(x) [fx(x), fy(x)], x0);

disp("\n druga norma priblizka nicle na (0.4, 0.4) je")
norm(nicla)






