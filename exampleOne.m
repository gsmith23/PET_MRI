% simple script to start reconstruction code running

% location of scan folder or folders
% NB final slash is required
%   Reading room PC
% pathToFolders = 'D:\Gary_RR\Ready\';
%   Laptop 
pathToFolders = 'C:\Data\JSRecon12-TestData\Ready\';

% execute the reconstruction process
% for all scans using all AC methods
doTheReconstructions(pathToFolders);

