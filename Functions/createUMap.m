function [ ] = createUMap( uMapType,  ...
                           pathToData)
% createUMap  Facilitate creation of uMap 
%
% One of two variations is implemented (NY or ED).
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
pathProcess = getPathProcess(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathToData);    

pathProcessData = getPathThisData(pathProcess, ...
                                  nameData);
                                                                             
% manufacturer uMap ( for fixing new UMap header info )
%  currently requires Dixon but could be extended to 
%  work with any manufacturer uMap
pathDXuMap     = getPathUMap(pathProcessData, ...
                             'DX'); 
                                                   
% vibes data                         
pathVibeData = getPathVibeData(pathProcessData, ...
                               uMapType);

% where created uMaps will go                               
pathVibeUMap = getPathVibeUMap(pathProcessData, ...
                               nameRadVibe, ...
                               uMapType);

mkdirIfAbsent(pathVibeUMap);
                       
switch uMapType
    case 'NY'  
        disp( ' ' );
        disp( ' Creating NYC uMap ' );
        disp( ' ' );
        
        createUMapNYC( pathVibeData , ...
                       pathVibeUMap);
        
    case 'ED' 
        disp( ' Creating EDI uMap ' );
        disp( ' ' );
        
        createUMapEDI( pathVibeData , ...
                       pathVibeUMap); 
    otherwise
        disp( '  ' );
        error( ' Unknown uMapType ' );
        
end  % switch uMapType  
    
% Vibe UMap header prep
prepareUMapHeaders( pathDXuMap,    ...
                    pathVibeUMap,  ...
                    uMapType);    
  
rmdirIfExisting(pathDXuMap);
rmdirIfExisting(pathRadVibeData);
    
pathCompletedUMap = getPathCompletedUMap(pathCompleted, ...
                                         nameData,      ...
                                         uMapType);

% copy uMaps 
copyData( pathVibeUMap, ...
          pathCompletedUMap);


end % function