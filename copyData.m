function [] = copyData( pathFrom, ...
                        pathTo)
% copyData() make a copy of the data folder 
%
% pathFrom - absolute path to folder containing data 
% pathTo   - absolute path to destination

% The destination folder will be created if
% it does not already exist
%
% gary.smith@ed.ac.uk   17 09 2018
%
% To do - Test alternative protocols: 
%         robocopy, python script, bbftp


robo = 0;

if(robo)
    options  = '/E /NFL /NDL /NJH';
    command  = ['ROBOCOPY ', pathFrom,' ', pathTo,' ', options];
    system(command);
else
    pathTo = ['\\?\',pathTo];
    copyfile(pathFrom,pathTo);
end

end

