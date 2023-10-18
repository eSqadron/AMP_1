load('soob_cmp.mat')
%%
f = figure
f.Position = [100 100 900 500];

range = 1:400;

semilogx(SUMAGR1{range,"FreqHz"}, SUMAGR1{range,"SPLdB"});
hold on
semilogx(SUMASBWOOFERSCIANA{range,"FreqHz"}, SUMASBWOOFERSCIANA{range,"SPLdB"});
semilogx(SUMASUBLEWO{range,"FreqHz"}, SUMASUBLEWO{range,"SPLdB"});
plot(74.2422, 63.931,'O')
xticks([20; 63; 100]);
xlabel("Pasmo Częstotliwości [Hz]");
ylabel("SPL [dB]");
title("Porównanie ustawienia soobwofera");
l = legend(["Poz 1 - Podstawowe ułożenie", "Poz 2 - Dosunięty do ściany", "Poz 3 - Dosunięty przesunięty w lewo"], 'Location','southeast');
l.AutoUpdate = "off";
exportgraphics(f,'1.png', 'Resolution',300)