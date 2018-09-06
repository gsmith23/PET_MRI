function pathTransData = setPathTransData( pathTrans,      ...
                                           nameData,       ...
                                           uMapType )
% setPathTransData    path for reconstructed data
% Data is copied to this path ready to be transfered on.
% Folder name used indicates uMaps used for reconstruction

pathTransData = [pathTrans,'\',nameData];

pathTransData = [pathTransData, '_', uMapType, '_Data'];    
    
end

