function statusJS = runJSRecon12( pathProcessing, nameData )
% runJSRecon12  execute JSRecon12 on the system
%
% The status is returned for use with subsequent commands
% System output can be suppressed
%
% gary.smith@ed.ac.uk   10 09 2018
%
% Note: filePathJSRecon12 is hard coded

% set to 0 to allow system output
nullSystemOut = 1;

pathData = [pathProcessing,'\',nameData];

filePathJSRecon12 = 'C:\JSRecon12\JSRecon12.js';

runCommand = ['cscript ', filePathJSRecon12,' ', pathData];

disp(' ');
disp(' executing: ')
disp(['   ', runCommand]);

    if(nullSystemOut) 
      runCommand = [runCommand,' > NUL'];   
    end

statusJS = system(runCommand);
    
end

