function drive = getNameDrive( pathData )
% getNameDrive Extract drive name from path to data
%
% gary.smith@ed.ac.uk   10 09 2018

pathDataArray = regexp(pathData,'\','split');

drive = pathDataArray(1);

end

