function pathTransUMaps = setPathTransUMaps( pathTrans,      ...
                                             nameData,       ...
                                             uMapType )
% setPathTransUMaps    path for uMaps used to reconstruct data
% UMaps are copied to this path ready to be transfered on.

pathTransUMaps = [pathTrans,'\',nameData];

pathTransUMaps = [pathTransUMaps, '_', uMapType, '_UMap'];    
    
end