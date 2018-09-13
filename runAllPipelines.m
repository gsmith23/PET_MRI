% runAllPipelines.m
% Version 1.0
%
% Script for executing Attenuation Correction (AC) 
% pipeline on multiple data sets and/or
% with multiple AC methods. 
%
%-------------------------------------------------------------
% Full Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) image reconstructions using
%   JSRecon12 and e7_tools.
%
%   Attenuation correction can be applied by: 
%   1) using existing uMaps
%       Dixon (DX), CT (CT), ...
%   2) creating uMaps using Radial/STAR Vibes data
%       Edinburgh (ED) & New York (NY) versions
%
% Author:
%   gary.smith@ed.ac.uk   13 09 2018
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
%-------------------------------------------------------------


disp('                                               ');
disp(' ----------------------------------------------');
disp('          Edinburgh Imaging Facility           ');
disp('              Cardiac PET MRI                  ');
disp('           Reconstruction Pipeline             ');
disp(' ----------------------------------------------');
disp('                                               ');

%---------------------------------------
% Location of master folder containing multiple 
% folders of data and uMaps in ready to process 
% convention.
%pathToReady = 'D:\Gary\Ready\';
pathToReady  = 'C:\Data\JSRecon12-TestData\Ready\';

%---------------------------------------
% List of folders in pathToReady 
% ensuring name includes the string 'Data' 
% (to omit: ., ..)
%   To do: test unique identifier 'Data'
folderList = ls([pathToReady,'*Data*']);

nFolders   = length(folderList(:,1));

%---------------------------------------
% Display the folder list
disp(' ');
disp(' Folders ready for pipeline: ');
disp(' ');
for iFolder = 1 : nFolders
     disp(['     ',folderList(iFolder,:)]);
end

%---------------------------------------
% Execute script to perform reconstructions
for iFolder = 1 : nFolders
        
   disp(' ');
   disp(' -----------');
   disp(' Running on: '); 
   disp(['   ', folderList(iFolder,:)]);
   
   pathToData = [pathToReady,folderList(iFolder,:)];
   
   runAllACPipelines(pathToData); 

end

