folder = 'bez_adaptacji_data/';
general_name = 'LEWY_SUB_ROG_p';



for i = 1:5
    for j = 1:5
        importfile(strcat(folder, general_name, num2str(i), '-', num2str(j), '.txt'))
    end
end