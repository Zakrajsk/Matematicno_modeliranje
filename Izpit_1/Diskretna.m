
function [X, Y] = Diskretna(w0, L_obesisce, D_obesisce, dolzine, mase)
  %vrne vsa krajisca od veriznice s podatki
  n = length(dolzine) - 1;

  %vmesne vsote
  Mi = zeros(1, n + 1);
  for i = 1 : n
    Mi(i + 1) = (mase(i) + mase(i + 1)) / 2;
  end
  
  %funkcija za fsolve
  F = @(w) F_uv(w, L_obesisce, D_obesisce, dolzine, Mi);

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

