function pathConvertedData = getPathConverted( pathProcessing, ...
                                               nameData)
% getPathConverted()  full path of reconstructed data folders
%   
% gary.smith@ed.ac.uk   01 09 2018

folderData  = ['\',nameData];
folderData  = [folderData,'-Converted'];
%folderData  = [folderData,'-Converted',folderData,'-00'];

pathConvertedData  = [pathProcessing,folderData];

end

