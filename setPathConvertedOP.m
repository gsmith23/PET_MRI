function pathConvertedOP = setPathConvertedOP( pathRecon, ...
                                               nameData)
% pathConvertedData  full path of reconstructed data folder
%
% This function returns the folder of e7_tools output 
% DICOM files of the type OP

folderData  = ['\',nameData];

pathConvertedOP  = [folderData,'-Converted'];

pathConvertedOP  = [pathConvertedOP,folderData,'-00'];

pathConvertedOP  = [pathConvertedOP,folderData,'-00-OP_000_000.v-DICOM'];

pathConvertedOP  = [pathRecon,pathConvertedOP];

end
