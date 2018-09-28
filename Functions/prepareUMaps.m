function [ ] = prepareUMaps( uMapType,  ...
                             pathToData)
% prepareUMaps  Facilitate creation of uMaps 
%
%   If creating Radial Vibe uMaps one of two  
%   variations is implemented (NY or ED).
%
% gary.smith@ed.ac.uk   28 09 2018
    

%-------------------------------------------------
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

pathProcessingData = getPathThisData(pathProcessing, ...
                                     nameData);
                                                                             
% manufacturer uMap
%  currently required Dixon but could be extended to 
%  any manufacturer uMap
pathDXuMaps     = getPathUMaps(pathProcessingData, ...
                               'DX'); 
                                                   
% vibes data                         
pathVibeData = getPathVibeData(pathProcessingData, ...
                               uMapType);

% where created uMaps will go                               
pathVibeUMaps = getPathVibeUMaps(pathProcessingData, ...
                                 nameRadVibe, ...
                                 uMapType);

mkdirIfAbsent(pathVibeUMaps);
                       
switch uMapType
    case 'NY'  
        disp( ' ' );
        disp( ' Creating NYC uMaps ' );
        disp( ' ' );
        
        createUMapsNYC( pathVibeData , ...
                        pathVibeUMaps);
        
    case 'ED' 
        disp( ' Creating EDI uMaps ' );
        disp( ' ' );
        
        createUMapsEDI( pathVibeData , ...
                        pathVibeUMaps); 
    otherwise
        disp( '  ' );
        error( ' Unknown uMapType ' );
        
end  % switch uMapType  
    
% Vibe UMap header prep
prepareUMapsHeaders( pathDXuMaps,    ...
                     pathVibeUMaps,  ...
                     uMapType);    
  
rmdirIfExisting(pathDXuMaps);
rmdirIfExisting(pathRadVibeData);
    
pathCompletedUMaps = getPathCompletedUMaps(pathCompleted, ...
                                           nameData,      ...
                                           uMapType);

% copy uMaps 
copyData( pathVibeUMaps, ...
          pathCompletedUMaps);


end % function