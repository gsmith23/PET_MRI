function drive = getNameDrive( pathData )
% getNameDrive Extract drive name from path to data

pathDataArray = regexp(pathData,'\','split');

drive = pathDataArray(1);

end

