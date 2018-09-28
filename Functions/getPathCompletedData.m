function pathCompletedData = getPathCompletedData( pathCompleted, ...
                                                   nameData,      ...
                                                   uMapType )
% getPathCompletedData()    path for reconstructed data
% Data is copied to this path ready to be transfered on.
% Folder name used indicates uMaps used for reconstruction
%
% gary.smith@ed.ac.uk   10 09 2018

pathCompletedData = [pathCompleted,'\',nameData];

pathCompletedData = [pathCompletedData, '_', uMapType, '\'];    
    
end

