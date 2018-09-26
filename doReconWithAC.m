function doReconWithAC(uMapType, ...
                       pathToData)
% doReconWithAC() execute reconstruction for one scan using one AC method
% 
% ---------------
%
% Description
%
%   This program is used to produce image reconstructions  
%   for PET MRI (or CT) data. Input arguments are used to specify 
%   which input data and attenuation correction method to use.
% 
%   The data and uMap are initially copied to a processing 
%   folder (Processing). 
%
%   If specified, a custom uMap is created using methods 
%   provided.
%
%   Once the data and uMap are prepared JSRecon12 is
%   executed on the data in the Processing folder. This 
%   results in the production of e7_tools scripts.
%
%   The e7_tools scripts are then executed which results
%   in the production of image reconstructions.
%
%   The image reconstructions are copied to an output folder
%   (Completed) with the corresponding uMap ready for transfer.
% 
% ---------------
% Input arguments 
%
%   uMapType: 'DX', 'CT' - use existing uMaps
%             'ED', 'NY' - create uMaps from Radial Vibes
%
%   pathToData: full path to the folder containing data folder/s 
%               and uMap folder/s   
%
% ---------------
% Author
%
%   gary.smith@ed.ac.uk     26 09 2018
%
%--------------------------
%--------------------------
%   Initialise Variables
%
% uMap/s and Radial Vibes
%  folder names

nameDXuMaps  = 'DX';

nameCTuMaps  = 'CT';  

nameRadVibe  = 'RV'; 

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
                         
% existing uMaps
pathCTuMaps     = getPathUMaps(pathProcessingData, ...
                               nameCTuMaps); 
                                                     
% existing uMaps
pathDXuMaps     = getPathUMaps(pathProcessingData, ...
                               nameDXuMaps); 
                                                   
% radial vibes data                         
pathRadVibeData = getPathRadVibeData(pathProcessingData, ...
                                     nameRadVibe);

% where created uMaps will go                               
pathRadVibeUMaps = getPathRadVibeUMaps(pathProcessingData, ...
                                       nameRadVibe, ...
                                       uMapType);
                                   
%-------------------------------------------------
%-------------------------------------------------
                                   

%--------------------------
%--------------------------
% Execute Reconstruction Process 
%
%--------------------------
% a) Copy raw data and uMaps to reconstruction location

copyData(pathToData,  ...
         pathProcessingData);
  
        
%--------------------------     
% b) Prepare custom uMaps

if( strcmp(uMapType,'RV') || ...
    strcmp(uMapType,'SV') )
    
  disp(' Rad Vibe' );
                
    
end


  prepareUMaps(uMapType,         ...
               pathDXuMaps,      ...
               pathCTuMaps,      ...
               pathRadVibeUMaps, ...
               pathRadVibeData);  
%--------------------------         
% c) Execute reconstruction process
runReconstruction(pathProcessing,nameData);

%--------------------------
% d) Copy the reconstructed data,  
%    and umaps to the destination

pathConvertedData  = getPathConvertedFolders(pathProcessing, ...
                                             nameData);

% Location to store converted data ready for transfer
pathCompleted  = getPathCompleted(pathRootFolder);

pathCompletedData  = getPathCompletedData(pathCompleted, ...
                                          nameData,      ...
                                          uMapType);
                               
pathCompletedUMaps = getPathCompletedUMaps(pathCompleted, ...
                                           nameData,      ...
                                           uMapType);

% copy data to transfer location
copyData( pathConvertedData, pathCompletedData);

% copy uMaps used for reconstruction to 
% transfer location

switch uMapType
    case 'DX'
        copyData( pathDXuMaps,      pathCompletedUMaps);
    case 'CT'
        copyData( pathCTuMaps,      pathCompletedUMaps);
    otherwise
        copyData( pathRadVibeUMaps, pathCompletedUMaps);
end

% clean up ready for next pipeline
% To Do: check on permissions 
% pause with message if no 'write'
rmdir(pathProcessing,'s');        

end

