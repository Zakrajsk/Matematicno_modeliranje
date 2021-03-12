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
  [L_X, L_Y] = Diskretna(w0, L_obesisce, premikamo, L_dolzine, L_mase);
  [D_X, D_Y] = Diskretna(w0, premikamo, D_obesisce, D_dolzine, D_mase);

  L_pote = Potencial_diskretna(L_X, L_Y, L_mase);
  D_pote = Potencial_diskretna(D_X, D_Y, D_mase);

  %sestejemo obe potencialni energiji
    potencialna = L_pote + D_pote;
end