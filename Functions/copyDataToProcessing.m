function [  ] = copyDataToProcessing( uMapType, ...
                                      pathToData )
% copyDataToProcessing()

% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathToData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathToData);

pathProcessingData = getPathThisData(pathProcessing, ...
                                  nameData);

pathToRawData = getPathToRawData(pathToData); 

copyData(pathToRawData, ...
         pathProcessingData)
     
% Dixon UMap is required to modify Vibes UMap headers
if ( strcmp(uMapType,'RV') || ...
     strcmp(uMapType,'SV') ) 
    
    uMapType = 'DX';
    
end

pathToUMap = getPathToUMap( pathToData, ...
                            uMapType );
        
pathProcessingDataUMap = [ pathProcessingData,'\',uMapType];
    
copyData(pathToUMap, ...
         pathProcessingDataUMap)

end

