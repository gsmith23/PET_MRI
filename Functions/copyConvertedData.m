function [  ] = copyConvertedData( uMapType, ...
                                   pathToData )
% copyConvertedData to 'Completed' folder
%
% gary.smith@ed.ac.uk   01 10 18
%

% Bottom level folder containing or to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathToData); 

pathConvertedData  = getPathConvertedFolders(pathProcessing, ...
                                             nameData);

% Location to store converted data ready for transfer
pathCompleted  = getPathCompleted(pathRootFolder);

pathCompletedData  = getPathCompletedData(pathCompleted, ...
                                          nameData,      ...
                                          uMapType);

%  copy converted data folders
%  ( see getPathCompletedData.m for comments)
copyData( pathConvertedData, pathCompletedData);

pathToUMap = getPathToUMap(pathToData, uMapType);

pathCompletedUMap  = getPathCompletedUMap(pathCompleted, ...
                                          nameData,      ...
                                          uMapType);

%  copy the uMap which used for the reconstruction
copyData( pathToUMap, pathCompletedUMap);

end

