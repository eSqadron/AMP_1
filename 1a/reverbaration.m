close all
range = 2:23; %63 do 8k
load("suma_RT60.mat")

dane = RT60SUMAGR1;
dla = "sumy głośników";
name_postix = "suma";
%%

f = figure
f.Position = [100 100 900 500];
semilogx(dane{range,"freqHz"}, dane{range,"T20s"});
xticks([63; 100; 1000; 4000; 8000]);
xlabel("Pasmo Częstotliwości [Hz]");
ylabel("Czas pogłosu [s]");
title("Zmierzony czas pogłosu dla " + dla);
exportgraphics(f,'1_' + name_postix + '.png', 'Resolution',300)

%%
range = 7:20; %200Hz do 4k

Tm = mean(dane{range,"T20s"})

%ponieważ Tm nie mieści się w zakresie, bierzemy tm zgodnie ze wzorem
%pomieszczenoa:

Tm = 0.23;

% obliczenia dopuszczalnych czasów pogłosu
range = 2:23; %63 do 8k

d_t = dane{range,"T20s"} - Tm;

f = figure
f.Position = [100 100 900 500];
semilogx(dane{range,"freqHz"}, d_t);
hold on
semilogx([200, 8000], [0.05, 0.05], Color="red", LineStyle="--");
semilogx([200, 4000], [-0.05, -0.05], Color="red", LineStyle="--");
semilogx([4000, 8000], [-0.1, -0.1], Color="red", LineStyle="--");
semilogx([63, 200], [0.3, 0.05], Color="red", LineStyle="--");
xlabel("Pasmo Częstotliwości [Hz]");
xticks([63; 100; 1000; 4000; 8000]);
ylabel("\Delta T [s]");
title("Tolerancja dla czasu pogłosu dla" + dla);
legend("" + "\Delta T", "Tolerancja");
exportgraphics(f,'2_' + name_postix + '.png', 'Resolution',300);

