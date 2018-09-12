function [ ] = mkdirIfAbsent( pathToDir )
% mkdirIfAbsent() create a new folder if is does exist

     if(~exist(pathToDir,'dir'))
        mkdir(pathToDir);   
     end

end

