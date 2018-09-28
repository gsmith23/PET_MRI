function pathCompletedUMap = getPathCompletedUMaps( pathCompleted, ...
                                                    nameData,      ...
                                                    uMapType )
% getPathCompletedUMaps() ie uMaps used to reconstruct data
% UMaps folder is copied to this path ready to be transfered on.
%
% gary.smith@ed.ac.uk   10 09 2018

pathCompletedUMap = [pathCompleted,'\',nameData];

pathCompletedUMap = [pathCompletedUMap, '_', uMapType, '_UMap'];    
    
end