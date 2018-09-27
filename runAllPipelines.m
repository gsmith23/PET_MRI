function [] = runAllPipelines(pathToReady)
% runAllPipelines() execute reconstruction process/es
%
% Version 1.0
%
% Script for executing e7tools reconstruction 
% pipeline on multiple PET MRI data sets and/or
% with multiple attenuation correction (AC) 
% methods. 
%
%-------------------------------------------------------------
% Full Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) image reconstructions using
%   JSRecon12 and e7_tools.
%
%   Attenuation corrections can be applied by: 
%   1) using existing uMaps
%       Dixon (DX), CT (CT), ...
%   2) creating uMaps using Radial/STAR Vibes data
%       Edinburgh (ED) & New York (NY) versions
%
%-----
% Input argument: 
%   pathToReady
%       Location of master folder containing multiple 
%       subfolders of data and uMaps in ready to process 
%       convention. 
%       NB Use absolute (not relative) path.
% 
%-----
% Author:
%   gary.smith@ed.ac.uk   23 09 2018
%
%-----
% Requirements:
%   JSRecon12
%       C:\JSRecon12\JSRecon12.js
%       C:\JSRecon12\JSRecon_params  (edit prior to running)
%
%   e7_tools
%       C:\Siemens\MRS\*  
%       C:\Siemens\PET\* 
%       C:\Service\*
%
%   DICOM dicionary (required for Radial/Star Vibes methods)
%       C:\Docs\dicom-dict-4PETMRI.txt
%
%-----
%  Note:  
%
%       The reconstruction process currently works on a
%       pre-formatted structure of data folders. Conventions 
%       must presently be implemented prior to running
%       the pipeline.
%       The next stage of development will be to automate
%       this convention.     
%  
%       Conventions:
%
%       Each sub-folder of pathToReady will only be processed 
%       if it contains the unique identifier string 'uniqueID' 
%       in its name. This variable is initialised below these
%       comments.
%
%       Sub-sub-folders must contain: 
%           a)   raw data in a folder containing 'Da' in the name;
%           b)i) a uMaps folder with: 
%                   'DX' (Dixon)
%                   'DN' (Dixon - no bone)
%                   'ML' (MLAA) 
%                   'CT' (CT)
%               in the name; and / or
%           b)ii) a Radial/STAR vibes folder with:
%                    'RV' (Radial Vibes) or
%                    'SV' (STAR VIBES) 
%               in the name, plus a Dixon uMaps folder
%               (for preparing the newly created UMap headers).
%-------------------------------------------------------------

% string to identify ready-to-process 
% scan data sub folders
uniqueID     = 'Data'; 

disp('                                               ');
disp(' ----------------------------------------------');
disp('          Edinburgh Imaging Facility           ');
disp('              Cardiac PET MRI                  ');
disp('           Reconstruction Pipeline             ');
disp(' ----------------------------------------------');
disp('                                               ');


%----------------------------------
% use preset value of pathToReady  
% if no input argument was given
if( isempty( pathToReady ) )
    % L - Laptop, R - Reporting room, E - E7tools PC
    location = 'L'; 
    pathToReady = setPathToReady(location);
end % if
%-----------

%---------------------------------------
% Display path to master folder 
disp(' ');
disp(' Path to folder of data ready for reconstructing: ');
disp([ '     ' , pathToReady ] );
disp(' ');

%---------------------------------------
% Obtain a list of folders in pathToReady 
% ensuring name includes the uniqueID string  
% ( results in omission of : ., .. )
folderList = ls([pathToReady,'*',uniqueID,'*']);

% integer to iterate to
nFolders   = length(folderList(:,1));

%---------------------------------------
% Display list of sub-folders 
disp(' ');
disp(' Folders ready for pipeline: ');
disp(' ');
for iFolder = 1 : nFolders
     disp(['     ',folderList(iFolder,:)]);
end

%---------------------------------------
% Execute master reconstruction script 
% once for each sub-folder
for iFolder = 1 : nFolders
        
   disp(' ');
   disp(' -----------');
   disp(' Running on: '); 
   disp(['   ', folderList(iFolder,:)]);
   
   pathToData = [pathToReady,folderList(iFolder,:)];
   
   runAllACPipelines(pathToData); 

end

