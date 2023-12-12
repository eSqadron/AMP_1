clearvars
pusto_l = importfile('RT_60/RT60_Kanal_lewy_pusto.txt');
pusto_r = importfile('RT_60/RT60_Kanal_prawy_pusto.txt');
pusto = importfile('RT_60/RT60_Suma_LR_pusto.txt');

wariant1_l = importfile('RT_60/RT60_Kanal_lewy_wariant1.txt');
wariant1_r = importfile('RT_60/RT60_Kanal_prawy_wariant1.txt');
wariant1 = importfile('RT_60/RT60_Suma_LR_wariant1.txt');

wariant2_l = importfile('RT_60/RT60_Kanal_lewy_wariant2.txt');
wariant2_r = importfile('RT_60/RT60_Kanal_prawy_wariant2.txt');
wariant2 = importfile('RT_60/RT60_Suma_LR_wariant2.txt');

wariant3_l = importfile('RT_60/RT60_Kanal_lewy_wariant3.txt');
wariant3_r = importfile('RT_60/RT60_Kanal_prawy_wariant3.txt');
wariant3 = importfile('RT_60/RT60_Suma_LR_wariant3.txt');

wariant4_l = importfile('RT_60/RT60_Kanal_lewy_wariant4.txt');
wariant4_r = importfile('RT_60/RT60_Kanal_prawy_wariant4.txt');
wariant4 = importfile('RT_60/RT60_Suma_LR_wariant4.txt');
save('RT60.mat');
%%
range = 2:23; %63 do 8k

f = figure;
f.Position = [100 100 900 500];

Tm = 0.23;

for i = 0:4
    dla = int2str(i);
    if(i == 0)
        dla = 'pustego';
    end
    wariant_str = int2str(i);

    if(i == 0)
        wariant_str = 'pusty';
    end
    
    switch i
       case 0
          dane = pusto;
       case 1
          dane = wariant1;
        case 2
          dane = wariant2;
          case 3
          dane = wariant3;
          case 4
          dane = wariant4;
       otherwise
          break
    end


    d_t = dane{range,"T20s"} - Tm;
    semilogx(dane{range,"FormatIsFreqHz"}, d_t);
    
    hold on;
    
    semilogx([200, 8000], [0.05, 0.05], Color="red", LineStyle="--");
    semilogx([200, 4000], [-0.05, -0.05], Color="red", LineStyle="--");
    semilogx([4000, 8000], [-0.1, -0.1], Color="red", LineStyle="--");
    semilogx([63, 200], [0.3, 0.05], Color="red", LineStyle="--");
    xlabel("Pasmo Częstotliwości [Hz]");
    xticks([63; 100; 1000; 4000; 8000]);
    ylabel("\Delta T [s]");
    title("Tolerancja dla czasu pogłosu dla wariantu " + dla);
    %legend("puste " + "\Delta T", "wariant 1 " + "\Delta T", "wariant 2 " + "\Delta T", "wariant 3" + "\Delta T", "wariant 4" + "\Delta T", "Tolerancja");
    legend("Wariant "+ wariant_str + " \Delta T", "Tolerancja");
    exportgraphics(f,"1_" + int2str(i) + ".png", 'Resolution',300);

    hold off;
end
%%
clearvars
pusto_l = importfile2('SPL/Kanal_lewy_pusto.txt');
pusto_r = importfile2('SPL/Kanal_prawy_pusto.txt');

wariant1_l = importfile2('SPL/Kanal_lewy_wariant1.txt');
wariant1_r = importfile2('SPL/Kanal_prawy_wariant1.txt');

wariant2_l = importfile2('SPL/Kanal_lewy_wariant2.txt');
wariant2_r = importfile2('SPL/Kanal_prawy_wariant2.txt');

wariant3_l = importfile2('SPL/Kanal_lewy_wariant3.txt');
wariant3_r = importfile2('SPL/Kanal_prawy_wariant3.txt');

wariant4_l = importfile2('SPL/Kanal_lewy_wariant4.txt');
wariant4_r = importfile2('SPL/Kanal_prawy_wariant4.txt');

save('SPLs.mat');

%%
for j= 0:4
    dla = int2str(j);
    switch j
       case 0
        dane_l = pusto_l;
        dane_r = pusto_r;

          dla = 'pustego';
       case 1
          dane_l = wariant1_l;
            dane_r = wariant1_r;
        case 2
          dane_l = wariant2_l;
            dane_r = wariant2_r;
          case 3
          dane_l = wariant3_l;
            dane_r = wariant3_r;
          case 4
            dane_l = wariant4_l;
            dane_r = wariant4_r;
       otherwise
          break
    end

    x_range = [];
    
    for i = 1:length(dane_l{:,"FreqHz"})
        if(dane_l{i,"FreqHz"} >= 200 && dane_l{i,"FreqHz"} <= 4000)
            x_range(end+1) = i;
        end
    end
    Lm_l = mean(dane_l{x_range,"SPLdB"});

    for i = 1:length(dane_r{:,"FreqHz"})
        if(dane_r{i,"FreqHz"} >= 200 && dane_r{i,"FreqHz"} <= 4000)
            x_range(end+1) = i;
        end
    end
    Lm_r = mean(dane_r{x_range,"SPLdB"});
    
    f = figure;
    f.Position = [100 100 900 500];
    
    subplot(2,1,1);
    semilogx(dane_l{:,"FreqHz"}, dane_l{:,"SPLdB"});
    hold on
    semilogx([50, 16000], [Lm_l, Lm_l], Color="green", LineStyle="--");
    semilogx([50, 16000], [Lm_l+3, Lm_l+3], Color="red", LineStyle="--");
    semilogx([50, 2000], [Lm_l-3, Lm_l-3], Color="red", LineStyle="--");
    semilogx([2000, 16000], [Lm_l-3, Lm_l-6], Color="red", LineStyle="--");

    xticks([50; 100; 1000; 4000; 8000; 16000]);
    xlabel("Pasmo Częstotliwości [Hz]");
    ylabel("SPL [dB]");
    title("Głośnik lewy");
    legend("Amplituda", "L_m = " + num2str(Lm_l,3), "Tolerancja");

    subplot(2,1,2);
    semilogx(dane_r{:,"FreqHz"}, dane_r{:,"SPLdB"});
    hold on
    semilogx([50, 16000], [Lm_r, Lm_r], Color="green", LineStyle="--");
    semilogx([50, 16000], [Lm_r+3, Lm_r+3], Color="red", LineStyle="--");
    semilogx([50, 2000], [Lm_r-3, Lm_r-3], Color="red", LineStyle="--");
    semilogx([2000, 16000], [Lm_r-3, Lm_r-6], Color="red", LineStyle="--");
    
    xticks([50; 100; 1000; 4000; 8000; 16000]);
    xlabel("Pasmo Częstotliwości [Hz]");
    ylabel("SPL [dB]");
    title("Głośnik prawy");
    legend("Amplituda", "L_m = " + num2str(Lm_r,3), "Tolerancja");

    sgtitle("Tolerancja amplitudy w pasmach częstotliwości dla wariantu " + dla) 

    exportgraphics(f, "2_" + int2str(j) + ".png", 'Resolution',300);
    
    hold off;
end