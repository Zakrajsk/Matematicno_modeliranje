function cas = Premica(zacetek, konec)
  %cas potovanja po premici 
  
  %premaknemo koordinate
  konec = konec - zacetek;
  zacetek = [0 0];
  gravitacija = 9.81;
  
  %izracunamo cas po formuli
  cas = sqrt(2 * (konec(1)^2 + konec(2)^2) / (gravitacija * -konec(2)));
end