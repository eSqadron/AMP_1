function data_table = import_all_data(folder, general_name)
    FreqHz = importfile(strcat(folder, general_name, '1-1.txt')).FreqHz;
    data_table = table(FreqHz);

    for i = 1:5
        for j = 1:5
            d = importfile(strcat(folder, general_name, num2str(i), '-', num2str(j), '.txt'));
            data_table.(strcat('SPLdB_', num2str(i), '_', num2str(j))) = d.SPLdB;
        end
    end

end

