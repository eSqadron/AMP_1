load("AMP_wyniki.mat");

sti_means = zeros(length(STI_male{:,1}), 1);

measurement_distances = 3-1.58:1:(3-1.58+7)

for i=1:length(STI_male{:,1})
    sti_means(i) = mean(STI_male{i,2:end});
end

%%
sti_in_the_neares_worstation = sti_means(1)


%%
close all;

mdl = fitlm(measurement_distances,sti_means);

b = mdl.Coefficients{"(Intercept)", "Estimate"};
a = mdl.Coefficients{"x1", "Estimate"};

f = figure();
f.Position = [100 100 900 500];

scatter(measurement_distances, sti_means, 'x');
hold on;
plot([0, 100], a*[0, 100]+ b);
% ax + b = rD
% x = (rD-b)/a
scatter((0.5-b)/a, 0.5);
scatter((0.2-b)/a, 0.2);
plot([0, 100], [0.5, 0.5], Color = "black", LineStyle="--");
plot([0, 100], [0.2, 0.2], Color = "black", LineStyle="--");

xlabel("Odległość [m]");
ylabel("STI");
ylim([0, 1]);
xlim([0,45]);

title("Zależność STI od odległości");
legend("punkty pomiarowe", "regresja liniowa", "rD = " + num2str((0.5-b)/a, 4), "rP = " + num2str((0.2-b)/a, 4));

exportgraphics(f, '1.png', 'Resolution',300);

%%

Sound_pressure_level_at_1m = Leq_db{1,2:end}; %Pomiar z pierwszego mikrofonu %[48.7, 59.1, 56.7 , 51.6, 46.1, 38.8, 31.9];
omnidir_speech_at_1m = [49.9, 54.3, 58 , 52, 44.8, 38.8, 33.5]; % Przeklepane z normy

% Eq. 2:
Dni = Leq_db;
Dni{:,2:end} = Sound_pressure_level_at_1m - Leq_db{:,2:end};

% Eq. 3:
Lpsni = Dni;
Lpsni{:,2:end} = omnidir_speech_at_1m - Dni{:,2:end};

% Eq4:

Lpasn = zeros(length(Lpsni{:,1}), 1);
for i = 1: length(Lpsni{:,1})
    Lpasn(i) = 10 * log10(sum(10.^((Lpsni{i,2:end} + [-16.1, -8.6, -3.2, 0, 1.2, 1, -1.1])/10)));

end

close all
f = figure();
f.Position = [100 100 900 500];

scatter(measurement_distances, Lpasn, 'x');
hold on;

mdl = fitlm(measurement_distances, Lpasn);
b = mdl.Coefficients{"(Intercept)", "Estimate"};
a = mdl.Coefficients{"x1", "Estimate"};

plot([0, 100], a*[0, 100]+ b);
% a * 4 +b = y
scatter(4, a * 4 +b);

xlim([0, 20]);

xlabel("Odległość [m]");
ylabel("L_{{\it p},A} [dB]");

title("Zależność L_{{\it p},A,S} od odległości");

legend("kolejne punkty L_{{\it p},A,S}", "regresja liniowa", "L_{{\it p},A,S, 4m} = " + num2str(a * 4 +b, 3) + "dB")



N = length(Leq_db{:,1});
logs_of_distances = log10(measurement_distances);

denominator = (N * sum(logs_of_distances.^2)) - sum(logs_of_distances).^2;

numenator = N * sum(Lpasn' .* logs_of_distances) - sum(Lpasn') * sum(logs_of_distances);

D2S = -log10(2) * (numenator./denominator)

((a*10+b)-44)/(58-44)

annotation('textarrow',[0.4, 0.5], [0.4, ((a*10+b)-44)/(58-44)],'String',"D2S = " + num2str(D2S, 3));

exportgraphics(f, '2.png', 'Resolution',300);


