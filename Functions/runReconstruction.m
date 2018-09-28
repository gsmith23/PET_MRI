function runReconstruction( pathToData )
% runReconstruction() executes runJSRecon12 then runE7Tools
% simple function to run the reconstruction process
% 

% gary.smith@ed.ac.uk   06 09 18


%-------------------------------------------------
% Set path variables
%
%
% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathToData);    

disp(' ');
disp(' path to data:');
disp(['   ',pathProcessing, '\', nameData]);

% run JSRecon12 
statusJS = runJSRecon12(pathProcessing, nameData);

disp(' ');

if(statusJS == 0)
    disp(' JSRecon12 ran successfully' );
else
    disp(' Error running JSRecon12 ' );
end

disp(' ');

% run E7Tools - if JSRecon12 successful
statusE7 = runE7Tools(pathProcessing, nameData, statusJS);

disp(' ');

if(statusE7 == 0)
    disp(' E7Tools ran successfully' );
else
    disp(' Error running E7Tools ' );
end
    
end

