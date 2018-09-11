% runManyPipelines.m
% Version 1.0
%
% Script for executing runPipeline() on multiple data sets 
% and/or with multiple attenuation correction methods. 
%
%-------------------------------------------------------------
% Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) image reconstructions using
%   JSRecon12 and e7_tools.
%
%   Attenuation correction can be applied by: 
%   1) using existing uMaps
%       Dixon (DX), CT (CT), ...
%   2) creating uMaps using Radial/STAR Vibes data
%       Edinburgh (ED), New York (NY) 
%
% Author:
%   gary.smith@ed.ac.uk   10 09 2018
%
% Requirements:
%   JSRecon12
%       C:\JSRecon12\JSRecon12.js
%       C:\JSRecon12\JSRecon_params  (set prior to running)
%
%   e7_tools
%       C:\Siemens\MRS\*  
%       C:\Siemens\PET\* 
%       C:\Service\*
%
%   DICOM dicionary (required for Radial Vibes method)
%       C:\Docs\dicom-dict-4PETMRI.txt
%
% Note:
%   At present uMaps and Radial Vibes folders
%   are hardcoded in runPipeline
%
%-------------------------------------------------------------

% Structure to contain 
% Folder paths 
% Attenuation Correction methods

% Location of master folder containing multiple folders of
% data and uMaps in ready to process convention
pathToReadyData = 'C:\Data\JSRecon12-TestData\Ready\';

%---------------------------------------
% Data Folder Paths
% List of folders in pathToReady (omitting ., ..)
scanFolders = ls([pathToReadyData,'*Data*']);

nFolders = length(scanFolders(:,1));
%---------------------------------------

%---------------------------------------
% uMaps
% DX, CT  - use existing uMaps
% ED, NY  - create uMaps from Radial Vibe
uMapsMasterList = ['ED';'NY';'DX'];

% initialise dataStruct
dataStruct(nFolders).pathToData = scanFolders(nFolders,:);
%dataStruct.subFolders(10) = zeros(:,:,:);  

for iFolder = 1 : nFolders
    scanFolders(iFolder,:) = [pathToReadyData(iFolder,:),scanFolders(iFolder,:)];
    dataStruct(iFolder).pathToData = scanFolders(iFolder,:);
    dataStruct(iFolder).subFolders = ls(scanFolders(iFolder,:));
end

%{dataStruct.pathToData}
{dataStruct(:,1).subFolders};

% nTypes = length(data.uMapTypeList(:,1));
% 
% % Execute image reconstructions on
% % folderList using all uMaps methods
% for iFolder = 1 : nFolders
%     for iType = 1 : nTypes
%     
%      runPipeline(data.uMapTypeList(iType,:), ...
%                  data.folderList(iFolder,:));
% 
%     end % for iUMapsType
% end