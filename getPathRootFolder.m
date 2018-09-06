function pathRootFolder = getPathRootFolder( pathData )
% getNameRootFolder Extract root folder name from path to data

[pathRootFolder, ~ , ~] = fileparts(pathData);