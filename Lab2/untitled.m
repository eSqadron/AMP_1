data_table_no_adaptations = import_all_data('bez_adaptacji_data/', 'LEWY_SUB_ROG_p');
data_table_with_adaptations = import_all_data('z_adaptacja_data/', 'LEWY_SUB_ROG_p');

%%
save('pomiary_5x5_dane', 'data_table_no_adaptations', 'data_table_with_adaptations');

%%
load('pomiary_5x5_dane.mat');

%%