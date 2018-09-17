function [] = copyDataType( pathFrom, ...
                            pathTo,   ...
                            type)
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

%--------------
% type 
% 0     copyfile
% 1     ROBOCOPY
% 2     

switch (type)
    case 1
        pathTo = ['\\?\',pathTo];
        copyfile(pathFrom,pathTo);
    case 2
        options  = '/E /NFL /NDL /NJH';
        command  = ['ROBOCOPY ', pathFrom,' ', pathTo,' ', options];
        system(command);
end

end
