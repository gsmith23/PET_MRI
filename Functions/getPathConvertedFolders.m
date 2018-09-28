function pathConvertedFolders = getPathConvertedFolders( pathProcessing, ...
                                                         nameData )
% getPathConvertedFolders() full path of reconstructed data folders
%
% This function returns the folders of e7_tools output DICOM files:
%     OP
%     uMap
%     hardware uMaps
%     mlaa uMap
%
%     .. plus other folders of the form *.v.DICOM
%
% gary.smith@ed.ac.uk   10 09 2018

folderData  = ['\',nameData];

pathConvertedFolders  = [folderData,'-Converted'];

pathConvertedFolders  = [pathConvertedFolders,folderData,'-00'];

pathConvertedFolders  = [pathConvertedFolders,folderData,'*.v-DICOM'];

pathConvertedFolders  = [pathProcessing,pathConvertedFolders];

end

