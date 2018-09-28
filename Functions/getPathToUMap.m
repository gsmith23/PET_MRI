function pathToUMap = getPathToUMap( pathToData, ...
                                     uMapType )
% getPathToUMap  full path to UMaps folder 
%
% gary.smith@ed.ac.uk   28 09 2018

pathToUMap = ls([pathToData,'\*',uMapType,'*']);

pathToUMap = [pathToData,'\',pathToUMap];


end

