function [  ] = deleteProcessingFolder( pathToData )
% deleteProcessingFolder() 

% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

rmdir(pathProcessing,'s'); 

end

