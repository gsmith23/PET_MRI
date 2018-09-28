function pathToRawData = getPathToRawData( pathToData )
% getPathToRawData() 

pathToRawData = ls([pathToData,'\*Raw_Data*']);

pathToRawData = [pathToData,'\',pathToRawData];

end

