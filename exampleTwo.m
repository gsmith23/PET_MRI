% simple script to start reconstruction code running

% path to scan folder contating raw data and uMap/s
%   Laptop example
pathToData = 'C:\Data\JSRecon12-TestData\Ready\VE11PTestData\';

% uMap type (Dixon)
uMapType = 'DX';

addpath('./Functions');

% execute the reconstruction process
% with a single AC method
doReconWithAC(uMapType, pathToData)