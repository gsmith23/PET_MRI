function pathConvertedFolders = getPathConvertedFolders( pathProcessing, ...
                                                         nameData )
% getPathConvertedFolders() full path of reconstructed data folders
%
% This function will return path the folders of e7_tools output 
% that will encasulate all the following DICOM files:
%     OP
%     uMap
%     hardware uMaps
%     mlaa uMap
%
%     .. plus other folders of the form *.v.DICOM
%     (check that no extras are copied which could happen if
%      JSRecon_params was not set up correctly)
%
% gary.smith@ed.ac.uk   01 10 2018

folderData  = ['\',nameData];

pathConvertedFolders  = [folderData,'-Converted'];

pathConvertedFolders  = [pathConvertedFolders,folderData,'-00'];

pathConvertedFolders  = [pathConvertedFolders,folderData,'*.v-DICOM'];

pathConvertedFolders  = [pathProcessing,pathConvertedFolders];

end

