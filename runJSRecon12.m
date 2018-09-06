function statusJS = runJSRecon12( pathRecon, nameData )
% runJSRecon12  execute JSRecon12 on the system
%
% The status is returned for use with subsequent commands
% System output can be suppressed
%
% gary.smith@ed.ac.uk 04 09 2018
%
% To do: filePathJSRecon12 is hard coded
%        but this might be better set 
%        from runManyPipelines()


% set to 1 to suppress system output
nullSystemOut = 1;

pathData = [pathRecon,'\',nameData];

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

