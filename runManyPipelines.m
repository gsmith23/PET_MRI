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
%       Dixon (DIX), CT (CAT), ...
%   2) creating uMaps using Radial/STAR Vibes data
%       Edinburgh (EDI), New York (NYU) 
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

% Location of data source 
% Edit as appropriate
data.folderList = ['D:\Gary\PETMRI_TestData_B20P_Test2'; ...
                   'D:\Gary\PETMRI_TestData_B20P_Test3'];
               
data.folderList = ['PETCT_TestData_G60_Test1'; ...
                   'PETCT_TestData_G60_Test2'];


nFolders = length(data.folderList(:,1));

% DIX, CAT  - use existing uMaps
% EDI, NYC  - create uMaps from Radial Vibe
% Edit as appropriate
data.uMapTypeList = ['ED';'NY';'DX'];

nTypes = length(data.uMapTypeList(:,1));

% Execute image reconstructions on
% folderList using all uMaps methods
for iFolder = 1 : nFolders
    for iType = 1 : nTypes
    
     runPipeline(data.uMapTypeList(iType,:), ...
                 data.folderList(iFolder,:));

    end % for iUMapsType
end