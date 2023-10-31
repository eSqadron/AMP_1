data_table_no_adaptations = import_all_data('bez_adaptacji_data/', 'LEWY_SUB_ROG_p');
data_table_with_adaptations = import_all_data('z_adaptacja_data/', 'LEWY_SUB_ROG_p');

%%
save('pomiary_5x5_dane', 'data_table_no_adaptations', 'data_table_with_adaptations');

%%
load('pomiary_5x5_dane.mat');

%%
close all;
load('pomiar_1.mat');

f = figure();
f.Position = [100 100 900 500];
semilogx(pomiar1{:,"FreqHz"}, pomiar1{:,"SPLdB"});

xticks([20; 50; 100; 200]);
xlabel("Częstotliwość [Hz]");
ylabel("SPL [dB]");

xlim([20, 200]);
title("Charakterysytka amplitudowo-częstotliwościowa w zakresie rezonansowym")

exportgraphics(f, '1.png', 'Resolution',300);

%%
close all;
x = 1:5;
y = 1:5;

probka = 115;
przed_po = "po";

dane = data_table_with_adaptations;


%temp_row = data_table_no_adaptations{probka,2:26} - data_table_with_adaptations{probka,2:26};

temp_row = dane{probka,2:26};
%temp_row = temp_row/max(temp_row)
v = reshape(temp_row, [5, 5]);

[Xq,Yq] = meshgrid(1:0.1:5);

Z_interp = interp2(x, y, v, Xq, Yq)';

f = figure;
f.Position = [100 100 900 500];
surf(Xq,Yq,Z_interp)
title('Original Sampling');
zlabel("SPL [dB]");
xlabel("punkty pomiarowe");
ylabel("punkty pomiarowe");
title(strcat("Rozkład poziomu ciśnienia dla częstotliwości ", num2str(dane{probka,1}, 3), "Hz ", "po adaptacji"));
yticks([1, 2, 3, 4, 5]);
xticks([1, 2, 3, 4, 5]);
%clim([85, 90]);
view(2);
hcb=colorbar;
hcb.Title.String = "SPL [dB]";

exportgraphics(f, strcat('3_', num2str(probka), "_", przed_po, '.png'), 'Resolution',300);

%%
close all;
x = 1:5;
y = 1:5;

probka = 115;

temp_row = data_table_no_adaptations{probka,2:26} - data_table_with_adaptations{probka,2:26};

v = reshape(temp_row, [5, 5]);

[Xq,Yq] = meshgrid(1:0.1:5);

Z_interp = interp2(x, y, v, Xq, Yq)';

f = figure;
f.Position = [100 100 900 500];
surf(Xq,Yq,Z_interp)
title('Original Sampling');
zlabel("SPL [dB]");
xlabel("punkty pomiarowe");
ylabel("punkty pomiarowe");
title(strcat("Różnica poziomu ciśnienia dla ", num2str(dane{probka,1}, 3), "Hz ", "przed i po adaptacji"));
yticks([1, 2, 3, 4, 5]);
xticks([1, 2, 3, 4, 5]);
%clim([85, 90]);
view(2);
hcb=colorbar;
hcb.Title.String = "\Delta SPL [dB]";

exportgraphics(f, strcat('4_', num2str(probka), '.png'), 'Resolution',300);
%%
close all;

f = figure();
f.Position = [100 100 900 500];
semilogx(data_table_no_adaptations{:,"FreqHz"}, data_table_no_adaptations{:,"SPLdB_2_3"}, DisplayName="przed adaptacją");
hold on
semilogx(data_table_with_adaptations{:,"FreqHz"}, data_table_with_adaptations{:,"SPLdB_2_3"}, DisplayName="po adaptacji");

legend();

xlabel("Częstotliwość [Hz]");
ylabel("SPL [dB]");
xticks([20; 50; 100; 200]);
xlim([20, 200]);

title("Charakterysytka amplitudowo-częstotliwościowa w zakresie rezonansowym")

exportgraphics(f, '5.png', 'Resolution',300);