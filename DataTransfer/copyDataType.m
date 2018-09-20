function [] = copyDataType( pathFrom, ...
                            pathTo,   ...
                            type)
% copyDataType() copy data with optional method/type
%
% pathFrom - absolute path to folder containing data 
%            example:
%               'R:\Storage\905MB_Data';
%
% pathTo   - absolute path to destination
%            example:
%               'F:\Gary_E7\905MB_Data_1'
%
% type     - transfer protocol  
%   1  copyfile() Matlab function
%   2  ROBOCOPY   system function
%
% The destination folder will be created if
% it does not already exist
%
% gary.smith@ed.ac.uk   20 09 2018
%

disp( '     ' );
disp( ' Transfering data from:' );
disp( [ '   ' , pathFrom ] );
disp( '                   to:');
disp( [ '   ' , pathTo ] );
disp( '     ' );

switch (type)
    case 1
        
        disp( ' Using type 1 - copyfile ' );
        
        % hack to fix bug with extenal USB drive
        %pathTo = ['\\?\',pathTo]; 
       
        copyfile(pathFrom,pathTo);
    case 2
        
        disp( ' Using type 2 - ROBOCOPY ' );
        
        %
        options  = '/E /NFL /NDL /NJH /MT /LOG:log_robocopy';
        command  = ['ROBOCOPY ', pathFrom,' ', pathTo,' ', options];
        disp( ['    ' , command ]);
        system(command);
end

%pause(2);

end
