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
%   2) creating uMaps using Radial/Star VIBE data
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
%   gary.smith@ed.ac.uk   24 09 2018
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
%   DICOM dicionary (required for Radial/Star VIBE methods)
%       C:\Docs\dicom-dict-4PETMRI.txt
%
%-----
%  Note:  
%
%       The reconstruction process currently works on a
%       pre-formatted data folder naming convention.  
%       The conventions must presently be implemented 
%       prior to running the pipeline.
%       The next stage of the pipeline development will aim  
%       to automate this convention.     
%  
%    Naming Convention:
%
%       Each sub-folder of pathToReady (each containing data   
%       for one scan) will only be processed if it's name    
%       contains a unique identifier string defined by the   
%       variable uniqueID. This variable is initialised  
%       directly below these comments.
%
%       Sub-sub-folders of pathToReady (sub-folders of each   
%       scan folder) must contain in their name:
%           a)   raw data in a folder containing 'Data';
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
% sub-folders of scan data
uniqueID     = 'Data'; 

disp('                                               ');
disp(' ----------------------------------------------');
disp('          Edinburgh Imaging Facility           ');
disp('             Cardiology PET MRI                ');
disp('           Reconstruction Pipeline             ');
disp(' ----------------------------------------------');


%----------------------------------
% allow preset value of pathToReady  
% if no input argument was given
if( isempty( pathToReady ) )
    % L - Laptop, R - Reporting room, E - E7tools PC
    
    % hard-coded option 
    location = 'R';
    
    if( isempty(location) ) 
        prompt = 'where are you located? (''R'',''E'',''L'')  ';
        location = input(prompt); 
    end
    
    pathToReady = getPathToReady(location);
end % if
%-----------

%---------------------------------------
% Display path to master folder 
disp(' ');
disp(' Path to folder of data ready for reconstructing: ');
disp([ '     ' , pathToReady ] );

%---------------------------------------
% Obtain a list of folders in pathToReady 
% ensuring name includes the uniqueID string  
% ( results in omission of : ., .. )
folderList = ls([pathToReady,'*',uniqueID,'*']);

% integer to iterate to
if( isempty( folderList ) )
   error(' No folders of scan data were found') 
else
    nFolders   = length(folderList(:,1));
end
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

