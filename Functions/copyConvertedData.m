function [  ] = copyConvertedData( uMapType, ...
                                   pathToData )
% copyConvertedData 

% Bottom level folder containing / to contain:
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
                               
copyData( pathConvertedData, pathCompletedData);

end

