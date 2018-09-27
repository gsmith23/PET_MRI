function pathRadVibeUMaps = getPathRadVibeUMaps( pathProcessingData, ...
                                                 nameRadVibeData,    ...
                                                 uMapType)
% getPathRadVibeUMaps() Return standardised path for created uMaps folder
%
% gary.smith@ed.ac.uk   10 09 2018

nameRadVibeUMaps = [ nameRadVibeData , '_', ...
                     uMapType        , '_', ...
                     'UMap'];
 
pathRadVibeUMaps = [pathProcessingData,'\',nameRadVibeUMaps];
                
end

