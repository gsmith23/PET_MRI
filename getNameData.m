function nameData = getNameData( pathData )
% getNameData Extract name of data folder from full path to data
%
% gary.smith@ed.ac.uk   17 09 2018

[~, nameData , ~] = fileparts(pathData);

% remove spaces from string
nameData = nameData(~isspace(nameData));

end

