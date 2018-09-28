function [  ] = deleteProcessFolder( pathToData )
% deleteProcessFolder() 

% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcess = getPathProcessing(pathRootFolder);

rmdirIfExisting(pathProcess); 

end

