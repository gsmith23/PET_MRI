function statusE7 = runE7Tools( pathRecon, dataName, statusJS )
% runE7Tools  Simple function to execute the e7tools  
%
%  Runs batch scripts created by JSRecon12.
%
%  Calls setPathScriptAll to set the path 
%  to the executable that runs a series of
%  batch scripts with name containing 'All'
%
%  Note that the specifics of the 'All' script
%  be altered using parameters in the file 
%  JSRecon_params
%
%  gary.smith@ed.ac.uk 04 09 2018
%

% set to 1 to suppress system output
nullSystemOut = 1;

runCommand  =  setPathAllScript(pathRecon,dataName);

if(nullSystemOut)
    runCommand  =  [runCommand,' > NUL 2>&1'];
end

if(statusJS == 0 )
    statusE7 = system(runCommand);
end 
    
end

