function koncne = izracunaj_krivuljo(zacetne, gladkost)
%Funckija preracuna tocke, ki predstavljajo Bezierjevo krivuljo. Funkcija
%deluje tako na 2D kot na 3D prostoru
%Parametri:
%           zacetne - tocke, ki so podane vsaka v svoji vrstici
%           gladkost - koliko korakov naredi metoda oziroma kako gladka je
%           krivulja
%Vrne:
%           koncne - tabela točk, ki predstavljajo krivuljo, točke so
%           podane v vrsticah

    t = linspace(0, 1, gladkost); 
    %naredimo prazno v katero bomo vstavljali izracunane tocke
    koncne = zeros(length(t), length(zacetne(1, :))); 
    
    %kopiramo prvo in zadnjo koordinato ker bo krivulja se stikala v teh
    %točkah
    koncne(1,:) = zacetne(1, :);
    koncne(length(t), :) = zacetne(end, :);
    
    for i = 2 : length(t) - 1 %glede na stevilo korakov 
       zacasne = zacetne; 
       razmerje = t(i); %shranimo katero razmerje sedaj gledamo v tem koraku
       
       for k = 1 : length(zacetne)
           for j = 1 : length(zacetne) - k
               zacasne(j, :) = (1 - razmerje) .* zacasne(j, :) + razmerje .* zacasne(j + 1, :);
           end
       end
       %V prvi vrsti imamo tukaj izracuno novo tocko, ki jo zapisemo v
       %koncne
       koncne(i, :) = zacasne(1, :);
    end
end