function [  ] = copyDataToProcessing( uMapType, ...
                                      pathToData )
% copyDataToProcessin()

% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathToData);

pathProcessData = getPathThisData(pathProcessing, ...
                                  nameData);

pathToRawData = getPathToRawData(pathToData);

copyData(pathToRawData, ...
         pathProcessData)
     
% Dixon UMap is required to modify Vibes UMap headers
if ( strcmp(uMapType,'RV') || ...
     strcmp(uMapType,'SV') ) 
    
    uMapType = 'DX';
    
end

pathToUMap = getPathToUMap( pathToData, ...
                            uMapType );
        
copyData(pathToUMap, ...
         pathProcessData)

end

