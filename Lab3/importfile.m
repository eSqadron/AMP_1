function RT60SumaLRpusto = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  RT60SUMALRPUSTO = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  RT60SUMALRPUSTO = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  RT60SumaLRpusto = importfile("C:\Users\OEM\Documents\AMP_1\Lab3\RT_60\RT60_Suma_LR_pusto.txt", [2, 25]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 12-Dec-2023 18:57:50

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, 25];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 18);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["FormatIsFreqHz", "BWoctaves", "EDTs", "r", "T20s", "r1", "T30s", "r2", "Topts", "r3", "ToptStartdB", "ToptEnddB", "T60Ms", "reverseforwardzeroPhaseFiltered", "C50dB", "C80dB", "D50", "TSs"];
opts.VariableTypes = ["double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["BWoctaves", "reverseforwardzeroPhaseFiltered"], "EmptyFieldRule", "auto");

% Import the data
RT60SumaLRpusto = readtable(filename, opts);

end