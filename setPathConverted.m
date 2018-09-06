function pathConvertedData = setPathConverted( pathRecon, ...
                                               nameData)
% pathConvertedData  full path of reconstructed data folders
%   

folderData  = ['\',nameData];
folderData  = [folderData,'-Converted'];
%folderData  = [folderData,'-Converted',folderData,'-00'];

pathConvertedData  = [pathRecon,folderData];

end

