function folderType = getFolderType( subFolder )
% getFolderType() return character array of folder type
% A search is done on 'subFolder' to match any of the
% (unique) identifiers in typeArray

% 
% DX  - Dixon uMaps
% ML  - MLAA uMaps
% CT  - CT uMaps
% RV  - Radial Vibes data
% 

typeArray = ['DX';'ML';'CT';'RV';'Da'];

nTypes = length(typeArray(:,1));

folderType = '';

for iType = 1 : nTypes
   
    type = typeArray(iType,:);
    
    if     (~isempty(strfind(subFolder,type)))
        folderType = type;
    end
    
end % for


end

