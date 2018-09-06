function [ pathReconData ] = setPathReconData( pathRecon, ...
                                               nameData)
% setPathReconData  full path of reconstructed data folders
%   

folderData  = ['\',nameData];

pathReconData  = [pathRecon,folderData];

end

