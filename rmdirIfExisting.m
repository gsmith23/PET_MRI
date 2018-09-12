function [ ] = rmdirIfExisting( pathToDir )
% rmdirIfExisting() remove folder if it exists
%
% gary.smith@ed.ac.uk

    if(exist(pathToDir,'dir'))
        rmdir(pathToDir,'s');
    end

end

