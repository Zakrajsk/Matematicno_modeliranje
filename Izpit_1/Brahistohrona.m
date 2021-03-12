function [cas, k, theta] = Brahistohrona(zacetek, konec)
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

function [opt_theta, k] = Optimalna_tk(b, B)
  %Izracuna optimalno theta in koeficient k
  
  g = @(theta) 1 - cos(theta) + (B / b) * (theta - sin(theta));
  
  %najdemo pri kateri theti je g == 0
  opt_theta = fzero(g, pi);
  %izracunamo k po formuli
  k = sqrt(2 * b / (opt_theta - sin(opt_theta))); 
  
end