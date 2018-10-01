function [ ] = doAllACMethods( pathToData )
% doAllACMethods() run doReconWithAC once for all AC methods
%
% Attenutation Correction (AC) methods are applied 
% according to which folder/s are present in pathToData
%
% gary.smith@ed.ac.uk   01 10 2018

%---------------------------------------
% Identify contents of pathToData folder
% to determine all possible AC methods

subFolderList = ls(pathToData);
nSubFolders   = length(subFolderList(:,1));

%-----------------------------
% Create list of uMaps
%   e.g. ['DX','CT','ED','NY']

% Type of uMaps:

% Use existing uMaps
% DX  - Dixon uMaps
% ML  - MLAA uMaps
% CT  - CT uMaps
% DN  - Dixon No Bone uMaps

% Create uMaps using Radial/Star Vibes Data 'RV' / 'SV'
% ED  - Edinburgh method
% NY  - New York method

% initialise first (dummy) element
%  (temporary solution)
uMapList      = 'XX';
rawDataFolder = [];

% Search subfolder names to identify
% folder type (contents)
% Note: this requires the subfolders to
% follow a naming convention 
% (ie contain an identifier)
for iSF = 1 : nSubFolders
    
    subFolder  = subFolderList(iSF,:);
    folderType = getFolderType(subFolder);
    
    switch folderType
        case 'DX' 
            uMapList = [uMapList; 'DX'];
        case 'DN'
            uMapList = [uMapList; 'DN'];
        case 'CT'
            uMapList = [uMapList; 'CT'];
        case 'ML'
            uMapList = [uMapList; 'ML'];
        case 'RV'
            uMapList = [uMapList; 'ED'; 'NY'];
        case 'SV'
            uMapList = [uMapList; 'ED'; 'NY'];
        case 'Raw_Data'
            rawDataFolder = subFolder;
     end
    
end % for iSF

% remove first (dummy) element
uMapList = uMapList(2:length(uMapList(:,1)),:);

disp(' ');
disp(' Raw Data Folder:')
disp(['  ',rawDataFolder]);

%---------------------------------------

% number of attenuation correction methods
nACs = length(uMapList(:,1));

disp(' ');
disp(' List of AC methods:')
for iAC = 1 : nACs
    disp(['  ',uMapList(iAC,:)]);
end

% run reconstruction process once for each AC method
for iAC = 1 : nACs
   disp(' ');
   disp([' Using ', uMapList(iAC,:), ' attenuation correction method'] );
   
   uMapType = uMapList(iAC,:);
   
   doReconWithAC(uMapType, pathToData);

end % for iAC

end
