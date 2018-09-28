function [] = doTheReconstructions(pathToFolders)
% doTheReconstructions() reconstruct raw data from multiple PET scans
% 
% Sub-folder/s of folders in 'pathToFolders' should contain    
% a folder of raw data plus one or more folder of uMaps   
% (and optionally a folder of Radial/Star Vibe data).
%
% Example:
%
%   pathToFolders = 'D:\Gary_RR\Ready\'
%
% contains two scan folders:
%   PETMRI_TestData_B20P_Test1
%   PETMRI_TestData_B20P_Test2
%
% The sub-folder PETMRI_TestData_B20P_Test1 for example
% contains the folders:
%   050Tho_50min_MRAC_NAF_PET_Raw_Data      % Raw PET Data
%   DX                                      % Dixon UMap
%   RV                                      % Radial Vibe data
%
%-------------------------------------------------------------
% Full Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) offline image reconstructions 
%   using JSRecon12 and e7_tools.
%
%   Attenuation corrections can be applied by: 
%   1) using existing uMaps
%       Dixon (DX/DN), CT (CT), MLAA (ML), 
%   2) creating uMaps using Radial/Star Vibes (RV)/(SV) data
%       Edinburgh (ED) & New York (NY) versions
%
%-----
% Input argument: 
%   pathToFolders
%       Location of master folder containing one or more  
%       subfolders of data folders and uMaps folders.
% 
%-----
% Author:
%   gary.smith@ed.ac.uk   27 09 2018
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
%  Note on version:  
%
%       This version of the reconstruction process works 
%       with pre-formatted folder naming conventions.  
%       Conventions must presently be implemented prior 
%       to running this program.  
%  
%   Conventions:
%
%       Each sub-folder of pathToFolders will be processed 
%       if it contains the unique identifier string, defined by 
%       variable 'uniqueID', somewhere in its name. This variable 
%       is initialised below these comments (and can be modified  
%       to suit any requirement/preference.)
%
%       Sub-sub-folders of pathToFolders (sub-folders of each   
%       scan folder) must contain in their name:
%           a)   raw data in a folder containing 'Raw_Data';
%           b)i) a uMaps folder with: 
%                   'DX' (Dixon)
%                   'DN' (Dixon - no bone)
%                   'ML' (MLAA) 
%                   'CT' (CT)
%               somewhere within the name; and / or
%           b)ii) a Radial/STAR vibes folder with:
%                    'RV' (Radial Vibes) or
%                    'SV' (STAR VIBES) 
%               within the name, plus a Dixon uMaps folder 
%               for preparing the newly created UMap headers.
%-------------------------------------------------------------

% string to identify ready-to-process 
% sub-folder/s of scan data
uniqueID     = 'Data'; 

disp('                                               ');
disp(' ----------------------------------------------');
disp('          Edinburgh Imaging Facility           ');
disp('             Cardiology PET MRI                ');
disp('           Reconstruction Pipeline             ');
disp(' ----------------------------------------------');


%---------------------------------------
% Display path to master folder 
disp(' ');
disp(' Path to folder of data ready for reconstructing: ');
disp([ '     ' , pathToFolders ] );
disp(' ');

%---------------------------------------
% Obtain a list of folders in pathToFolders 
% ensuring their name includes the uniqueID string  
% ( results in omission of ., .. from the list 
%  plus of course the omission of other folders not 
%  containing the uniqueID )
folderList = ls([pathToFolders,'*',uniqueID,'*']);

% check that there is a list and if so
% make an integer variable to iterate to
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

addpath('./Functions');

%---------------------------------------
% Execute master reconstruction script 
% once for each sub-folder
for iFolder = 1 : nFolders
        
   disp(' ');
   disp(' -----------');
   disp(' Preparing to reconstuct: '); 
   disp(['   ', folderList(iFolder,:)]);
   
   pathToData = [pathToFolders,folderList(iFolder,:)];
   
   pathToData = pathToData( find(~isspace(pathToData)));
   
   doAllACMethods(pathToData); 

end

