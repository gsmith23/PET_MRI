% Simple script to execute image reconstruction code.
%
%   gary.smith@ed.ac.uk  01 10 18
%
% This code can be used to do a single reconstruction.
%
% Path to scan folder containing raw data and a uMap
%  Note: set to the name of a folder containing a
%        sub-folder of raw data and a Dixon uMap sub-folder
%        The raw data folder should contain 'Raw_Data' in 
%        somewhere within its name.
% Reading Room PC example:
pathToData = 'D:\Gary_RR\Ready\PETMRI_TestData_B20P_Test1';

% uMap type (Dixon)
% NB Dixon uMap folder must contain 'DX' in its name
uMapType = 'DX';

% path to functions
addpath('./Functions');

% execute the reconstruction process
% with a single AC method
doReconWithAC(uMapType, pathToData)
