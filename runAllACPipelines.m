function [ ] = runAllACPipelines( pathToData )
% runManyACPipelines() execute runACPipeline once for all AC methods
%
% The AC methods are applied according to which folder/s
% are present in pathToData
%

%---------------------------------------
% Identify contents of pathToData folder
% to determine all possible AC methods
%

subFolderList = ls(pathToData);
nSubFolders = length(subFolderList(:,1));

% initialise first (dummy) element
uMapsList = ['XX'];
rawDataFolder = [];
% 
% DX  - use existing Dixon uMaps
% DN  - use existing Dixon No Bone uMaps
% DB  - use existing Dixon Bone uMaps
% DX  - use existing CT uMaps
% ED  - create uMaps using Edinburgh method
% NY  - create uMaps using New York method

for iSF = 1 : nSubFolders
    
    subFolder  = subFolderList(iSF,:);
    folderType = getFolderType(subFolder);
    
    switch folderType
        case 'DX'
            uMapsList = [uMapsList; 'DX'];
        case 'CT'
            uMapsList = [uMapsList; 'CT'];
        case 'ML'
            uMapsList = [uMapsList; 'ML'];
        case 'RV'
            uMapsList = [uMapsList; 'ED'; 'NY'];
        case 'Da'
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
% DX, CT  - use existing uMaps
% ED, NY  - create uMaps from Radial Vibe

nACs = length(uMapsList(:,1));

for iAC = 1 : nACs
   
   disp(' ');
   disp([' Using ', uMapsList(iAC,:), ' attenuation correction method'] );
   
   uMapType = uMapsList(iAC,:);
   
   runACPipeline(uMapType, pathToData);

end % for iAC



end

