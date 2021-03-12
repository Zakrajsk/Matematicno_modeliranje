function rez = Potencial_diskretna(X, Y, mase)
  %izracuna potenicalno energijo za neko veriznico
  gravitacija = 9.81;
  rez = 0;
  n = length(mase) - 1;

  for i = 1 : n + 1
    rez = rez + (mase(i) * gravitacija * ((Y(i) + Y(i + 1)) / 2));
  end
end