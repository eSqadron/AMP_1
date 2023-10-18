close all

load("SPL_data_tercje_tercje.mat");

dane = RIGHTGR1;

dla = "głośnika prawego";
name_postix = "r";

% semilogx(dane{:,"FreqHz"}, dane{:,"SPLdB"});
% xlabel("Pasmo Częstotliwości [Hz]");
% ylabel("SPL");
% title("Amplituda dźwięku dla danych częstotliwości dla głośnika prawego");
%%
x_range = [];

for i = 1:length(dane{:,"FreqHz"})
    if(dane{i,"FreqHz"} >= 200 && dane{i,"FreqHz"} <= 4000)
        x_range(end+1) = i;
    end
end

Lm = mean(dane{x_range,"SPLdB"})
%%
f = figure
f.Position = [100 100 900 500];

range = 4:29;

semilogx(dane{range,"FreqHz"}, dane{range,"SPLdB"});
hold on
semilogx([50, 16000], [Lm, Lm], Color="green", LineStyle="--");
semilogx([50, 16000], [Lm+3, Lm+3], Color="red", LineStyle="--");
semilogx([50, 2000], [Lm-3, Lm-3], Color="red", LineStyle="--");
semilogx([2000, 16000], [Lm-3, Lm-6], Color="red", LineStyle="--");

xticks([50; 100; 1000; 4000; 8000; 16000]);
xlabel("Pasmo Częstotliwości [Hz]");
ylabel("SPL [dB]");
title("Tolerancja amplitudy dźwięku w pasmach częstotliwości dla " + dla);
legend("Amplituda", "L_m = " + num2str(Lm,3), "Tolerancja");
exportgraphics(f, '1_' + name_postix + '.png', 'Resolution',300);