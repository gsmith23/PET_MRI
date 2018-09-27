function pathRootFolder = getPathRootFolder( pathData )
% getNameRootFolder() Extract root folder name from path to data
%
% gary.smith@ed.ac.uk   10 09 2018

[pathRootFolder, ~ , ~] = fileparts(pathData);