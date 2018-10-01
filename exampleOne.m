% a simple script to start the reconstruction code running

% path to scan folder containing raw data and a uMap
%  Note: modify to the name of a folder containing a
%        sub-folder of raw data and a Dixon uMap sub-folder
%        The raw data folder should contain 'Raw_Data' in 
%        somewhere within its name.
pathToData = 'C:\Data\JSRecon12-TestData\Ready\VE11PTestData\';

% uMap type (Dixon)
% NB Dixon uMap folder must contain 'DX' in its name
uMapType = 'DX';

% path to functions
addpath('./Functions');

% execute the reconstruction process
% with a single AC method
doReconWithAC(uMapType, pathToData)
