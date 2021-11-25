function koncne_tocke = prezrcali_tocke(tocke, smer)
%Funckija prezrcali podane tocke v smeri vektorja na ravnino z = 0
%Parametri:
%           tocke - Matrika tock, ki jih zelimo prezrcaliti
%           smer - Smer, ki je podana kot vektor [x, y, z] in pove v
%           kateri smeri zelimo prezrcaliti tocke
%Vrne:
%           koncne_tocke - matriko tock, ki so sedaj prezrcaljene na
%           ravnino z = 0

koncne_tocke = zeros(length(tocke), 2); %2 ker slikamo zdaj v 2D prostor

for i = 1 : length(tocke)
    za_koliko_zmanjsamo = tocke(i, 3) / smer(3); %izracun za koliko premaknemo krivuljo navzdol
    %na podlagi te tocke nato izracunamo kam premaknemo ostale točke, da
    %bojo v podani smeri. (To se bi najbrž dalo z kakšnimi vektorji ampak
    %trenutno ne vem kako)
    koncne_tocke(i, :) = [tocke(i, 1) - (smer(1) * za_koliko_zmanjsamo); tocke(i, 2) - (smer(2) * za_koliko_zmanjsamo)];
end

end

