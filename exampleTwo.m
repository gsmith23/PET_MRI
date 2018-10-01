% Simple script to execute image reconstruction code.
%
%   gary.smith@ed.ac.uk  01 10 18
%
% This code can be used to do multiple reconstructions
% with all available AC methods on data from multiple 
% PET MRI scans.
% 
% Before running read the comments in
% doTheReconstructions.m and follow
% the instructions.

% Location of scan folder or folders
% NB final slash is required
%   Reading room PC example below.
%   This folder is set up and ready to use.
pathToFolders = 'D:\Gary_RR\Ready\';

% execute the reconstruction process
% for all scans using all AC methods
doTheReconstructions(pathToFolders);



