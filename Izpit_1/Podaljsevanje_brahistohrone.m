function cas_podaljsan = Podaljsevanje_brahistohrone(povecava, theta, k, zacetek)
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
  [cas_potovanja, k, theta] = Brahistohrona(zacetek, nov_konec);
  
  %-1.5 zato, ker iscemo z fzero in rabimo kdaj bo cas potovanja 1.5
  cas_podaljsan = cas_potovanja - 1.5;
end