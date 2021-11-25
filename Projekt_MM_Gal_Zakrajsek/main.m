%st tock pove koliko kontrolnih točk bo imela nasa krivulja
%matrika tocke vsebuje vse tocke, podane so v vrsticah
%gladkost krivulje nam pove koliko tock bo sestavljalo krivuljo (vec ko jih
%je bolj gladka bo izgledala krivulja na grafu
tocke = [0 1 1; 1 3 0; 4 1 0; 2 3 3; 3 1 4; 5 2 1; 6 5 2];
gladkost_krivulje = 20; 

smer_zrcaljenja = [0; 0; 1]; %vektor nam pove iz katere smeri zrcalimo na ravnino z = 0


%v naslednjem razcepu preracunamo kje mora teci krivulja in jo narisemo 
tocke_za_risat = izracunaj_krivuljo(tocke, gladkost_krivulje);

figure(1)
plot3(tocke_za_risat(:, 1), tocke_za_risat(:, 2), tocke_za_risat(:, 3), 'b');
title('Krivulja v 3D')


hold on
plot3(tocke(:,1), tocke(:, 2), tocke(:, 3), 'ro'); %narise kontrolne tocke
plot3(tocke(:, 1), tocke(:, 2), tocke(:, 3), 'k-'); %poveže kontrolne točke


%narisemo se smer v kateri zrcalimo, to je rumena premica ki kaze smer
plot3([0 smer_zrcaljenja(1)*5], [0 smer_zrcaljenja(2)*5], [0 smer_zrcaljenja(3)*5], 'y-');
legend('krivulja', 'kontrolne tocke', 'povezava tock','smer zrcaljenja');
hold off


%v naslednjem delu prezrcalimo krivuljo v smeri zrcaljena na ravnino z = 0
%in jo tako narisemo v 2D grafu.
prezrcaljena_krivulja = prezrcali_tocke(tocke_za_risat, smer_zrcaljenja);

figure(2)
hold on
plot(prezrcaljena_krivulja(:, 1), prezrcaljena_krivulja(:, 2), 'b');
title('Prezrcaljena 3D krivulja');
hold off


%v naslednjem delu pa bomo najprej tocke prezrcalili na 2d ravnino in potem
%narisali breizirjevo krivuljo v 2D
prezrcaljene_tocke = prezrcali_tocke(tocke, smer_zrcaljenja);
krivulja_prezrcaljenih = izracunaj_krivuljo(prezrcaljene_tocke, gladkost_krivulje); 

figure(3)
hold on
plot(prezrcaljene_tocke(:, 1), prezrcaljene_tocke(:, 2), 'ro');
plot(prezrcaljene_tocke(:, 1), prezrcaljene_tocke(:, 2), 'k-');
plot(krivulja_prezrcaljenih(:, 1), krivulja_prezrcaljenih(:, 2), 'b')
title('Krivulja iz prezrcaljenih tock');
hold off

%V tem delu samo se preverimo ce sta krivulji enaki (seveda je to razvidno
%tudi iz zgornih grafov
ali_sta_enaki = isequal(prezrcaljena_krivulja, krivulja_prezrcaljenih);
if ali_sta_enaki == 1 
disp("Prezrcaljeni krivulji sta enaki");
 end

