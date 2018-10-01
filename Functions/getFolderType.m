function folderType = getFolderType( subFolder )
% getFolderType() return character array of folder type
%
% A search is performed on 'subFolder' to match any of the
% (unique) identifiers in uMapTypeIDArray

% folderType options 
% 'DX'  - Dixon uMaps
% 'DN'  - Dixon No Bone uMaps
% 'ML'  - MLAA uMaps
% 'CT'  - CT uMaps
% 'RV'  - Radial Vibes data
% 'SV'  - Star Vibes data
%
% 'Raw_Data'  - Raw Data 
%
%  gary.smith@ed.ac.uk  01 10 2018
%
% strings to search in subFolder name for
uMapTypeIDArray = ['DX';'DN';'ML';'CT';'RV';'SV'];
rawDataID       = 'Raw_Data';

nTypes = length(uMapTypeIDArray(:,1));

folderType = '';

    % search through list of uMap types
    for iType = 1 : nTypes
   
        uMapType = uMapTypeIDArray(iType,:);
        %disp([subFolder,'---']);
        
        if( strfind( subFolder, uMapType ) )
            folderType = uMapType;
        
        end
    
    end % for

    if( strfind(  subFolder, rawDataID ) )
        folderType = 'Raw_Data';
    end
end

