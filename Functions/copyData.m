function [] = copyData( pathFrom, ...
                        pathTo)
% copyData() make a copy of the data folder 
%
% pathFrom - absolute path to folder containing data 
% pathTo   - absolute path to destination

% The destination folder will be created if
% it does not already exist
%
% gary.smith@ed.ac.uk   20 09 2018
%
% To do - Test alternative protocols: 
%         robocopy, python script, bbftp

copyfile(pathFrom,pathTo);

end

