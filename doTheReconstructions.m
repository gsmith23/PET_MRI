function [] = doTheReconstructions(pathToFolders)
% doTheReconstructions() reconstruct raw data from multiple PET scans
% 
% Sub-folder/s of 'pathToFolders' should contain a folder of raw   
% data plus one or more folder of uMaps (and optionally a folder  
% of Radial/Star Vibe data).
%
% Version 1.0
%
%-------------------------------------------------------------
% Full Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) offline image reconstructions 
%   using JSRecon12 and e7_tools.
%
%   Attenuation corrections can be applied by: 
%   1) using existing uMaps
%       Dixon (DX), CT (CT), ...
%   2) creating uMaps using Radial/Star Vibes data
%       Edinburgh (ED) & New York (NY) versions
%
%-----
% Input argument: 
%   pathToFolders
%       Location of master folder containing one or more  
%       subfolders of data folders and uMaps folders.
%       NB Use absolute (not relative) path.
% 
%-----
% Author:
%   gary.smith@ed.ac.uk   26 09 2018
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
%       The reconstruction process currently works on 
%       pre-formatted folder naming conventions.  
%       Conventions must presently be implemented prior 
%       to running this program.  
%  
%   Conventions:
%
%       Each sub-folder of pathToFolders will be processed 
%       if it contains the unique identifier string, defined by 
%       variable 'uniqueID', somewhere in its name. This variable 
%       is initialised below these comments (and can be modified  
%       to suit any requirement/convention.)
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
% if no input argument was given
% use preset value of pathToFolders  

if( isempty( pathToFolders ) )
    
    % L - Laptop, R - Reporting room, E - E7tools PC
    
    % use hard coded value (comment in/out)
    %location = 'E'; 
    
    % if no 
    pathToFolders = getPathToFolders(location);
end % if
%-----------

%---------------------------------------
% Display path to master folder 
disp(' ');
disp(' Path to folder of data ready for reconstructing: ');
disp([ '     ' , pathToFolders ] );
disp(' ');

%---------------------------------------
% Obtain a list of folders in pathToReady 
% ensuring name includes the uniqueID string  
% ( results in omission of : ., .. )
folderList = ls([pathToFolders,'*',uniqueID,'*']);

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
   
   pathToData = [pathToFolders,folderList(iFolder,:)];
   
   runAllACPipelines(pathToData); 

end

