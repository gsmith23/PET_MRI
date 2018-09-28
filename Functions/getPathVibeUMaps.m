function pathVibeUMaps = getPathVibeUMaps( pathProcessingData, ...
                                           nameVibeData,    ...
                                           uMapType)
% getPathVibeUMaps()  standardised path for created uMaps folder
%
% gary.smith@ed.ac.uk   28 09 2018

nameVibeUMap = [ nameVibeData , '_', ...
                 uMapType     , '_', ...
                 'UMap'];
 
pathVibeUMaps = [pathProcessingData,'\',nameVibeUMap];
                
end

