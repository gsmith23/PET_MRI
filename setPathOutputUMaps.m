function pathOutputUMaps = setPathOutputUMaps( pathRecon,      ...
                                               nameData,       ...
                                               nameRadialVibe, ...
                                               uMapType)
% createPathOutputUMaps Return standardised path for created uMaps folder

nameOutputUMaps = [ nameRadialVibe , '_', ...
                    uMapType       , '_', ...
                    'UMap'];

pathOutputUMaps = [pathRecon,'\',nameData];
pathOutputUMaps = [pathOutputUMaps,'\',nameOutputUMaps];
                
end

