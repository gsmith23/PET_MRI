function folderType = getFolderType( subFolder )
% getFolderType() return character array of folder type
%
% A search is performed on 'subFolder' to match any of the
% (unique) identifiers in typeArray

% folderType options 
% DX  - Dixon uMaps
% DX  - Dixon No Bone uMaps
% ML  - MLAA uMaps
% CT  - CT uMaps
% RV  - Radial Vibes data
% SV  - Star Vibes data
% Da  - Raw Data 


% strings to search in subFolder name for
typeArray = ['DX';'DN';'ML';'CT';'RV';'SV';'Da'];

nTypes = length(typeArray(:,1));

folderType = '';

    for iType = 1 : nTypes
   
        type = typeArray(iType,:);
    
        if( contains( subFolder,type ) )
  
            folderType = type;
        
        end
    
    end % for

end

