function [ ] = runAllACPipelines( pathToData )
% runAllACPipelines() execute runACPipeline once for all AC methods
%
% Attenutation Correction (AC) methods are applied 
% according to which folder/s are present in pathToData
%
% gary.smith@ed.ac.uk   24 09 2018

%---------------------------------------
% Identify contents of pathToData folder
% to determine all possible AC methods

subFolderList = ls(pathToData);
nSubFolders   = length(subFolderList(:,1));

%-----------------------------
% Create list of uMaps
%   e.g. ['DX','CT','ED','NY']

% Type of uMaps

% Use existing uMaps
% DX  - Dixon uMaps
% ML  - MLAA uMaps
% CT  - CT uMaps
% [to be included] 
% [DN  - Dixon No Bone uMaps]
% [DB  - Dixon Bone uMaps]
% [CP  - psuedo CT from MR]

% Create uMaps using Radial VIbes Data 'RV'
% ED  - Edinburgh method
% NY  - York method

%   initialise first (dummy) element
uMapsList     = 'XX';
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
            uMapsList = [uMapsList; 'DX'];
        case 'DN'
            uMapsList = [uMapsList; 'DN'];
        case 'CT'
            uMapsList = [uMapsList; 'CT'];
        case 'ML'
            uMapsList = [uMapsList; 'ML'];
        case 'RV'
            uMapsList = [uMapsList; 'ED'; 'NY'];
        case 'SV'
            uMapsList = [uMapsList; 'ED'; 'NY'];
        case 'Raw_Data'
            rawDataFolder = subFolder;
     end
    
end % for iSF

% remove first (dummy) element
uMapsList = uMapsList(2:length(uMapsList(:,1)),:);

disp(' ');
disp(' Raw Data Folder:')
disp(['  ',rawDataFolder]);

%---------------------------------------
% uMaps
% DX, CT  (e.g.) - use existing uMaps
% ED, NY  (e.g.) - create uMaps from Radial Vibe

% number of attenuation correction methods
nACs = length(uMapsList(:,1));

disp(' ');
disp(' List of AC methods:')
for iAC = 1 : nACs
    disp(['  ',uMapsList(iAC,:)]);
end

% run reconstruction process once for each AC method
for iAC = 1 : nACs
   disp(' ');
   disp([' Using ', uMapsList(iAC,:), ' attenuation correction method'] );
   
   uMapType = uMapsList(iAC,:);
   
   %runACPipeline(uMapType, pathToData);

end % for iAC



end

