function runPipeline(uMapType, ...
                     pathData)
% runPipeline() execute PET MRI reconstruction pipeline
% 
% ---------------
%
% Description
%
%   This program is used to produce image reconstructions  
%   for PET MRI (or CT) data. Input arguments are used to specify 
%   which input data and attenuation correction method to use.
% 
%   The data and uMaps are initially copied to a processing 
%   folder (Processing). 
%
%   If specified a custom uMap is created using methods 
%   provided.
%
%   Once the data and uMaps are prepared JSRecon12 is
%   executed on the data in the Processing folder. This 
%   results in the production of e7_tools scripts.
%
%   The e7_tools scripts are then executed which results
%   in the production of image reconstructions.
%
%   The image reconstructions are copied to an output folder
%   (Completed) with the corresponding uMaps ready for transfer.
% 
% ---------------
% Input arguments 
%
%   uMapType: 'DX', 'CT' - use existing uMaps
%             'ED', 'NY' - create uMaps from Radial Vibes
%
%   pathData: full path to the folder containing data folders 
%             and uMaps folders   
%
% ---------------
% Author
%
%   gary.smith@ed.ac.uk     10 09 201
%
%--------------------------
%--------------------------
%   Initialise Variables
%
% To do: 
%   Move uMaps and Radial Vibes folders 
%   to runManyPipelines.m
%   and add as input variables:
%
%   Only copy data and/or uMaps relevant to the 
%   uMap type to Processing folder
%
%   Change pathProcessing and pathTrans to 
%   paths relative to root folder
%
%--------------------------

%
% uMaps and Radial Vibes
%   To Do:  initialise in runManyPipelines()
%           and pass as argument
%           Ultimately standardise by searching 
%           folder names for string comparisons
%           using this to change folder names 
%           to the same convention for all data.
%
nameDXuMaps  = 'Dixon_umap'; 
nameCTuMaps  = 'Static-CT';  
nameRadVibe  = 'RadialVIBE'; 
   
% Data/scanner version: 'B20' or 'E11';
% required for Radial Vibe EDI 
%   To Do: extract from DICOM header info
dataVersion = 'B20';

%-------------------------------------------------
%-------------------------------------------------
% Set path variables
%
%
% Bottom level folder containing / to contain:
% [Data], Processing, and Completed folders
pathRootFolder = getPathRootFolder(pathData);

% Location for processing data
pathProcessing = getPathProcessing(pathRootFolder);

% Location to store converted data ready for transfer
pathCompleted  = getPathCompleted(pathRootFolder);

% name of Data (folder)  
nameData = getNameData(pathData);    


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
% Execute Pipeline 
%
%--------------------------
% a) Copy raw data and uMaps to reconstruction location

copyData(pathData,  ...
         pathProcessingData);
  
        
%--------------------------     
% b) Prepare custom uMaps
prepareUMaps(uMapType,         ...
             dataVersion,      ...
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

pathConvertedData  = getPathConvertedOP(pathProcessing, ...
                                        nameData);

pathCompletedData  = getPathCompletedData(pathCompleted, ...
                                          nameData,      ...
                                          uMapType);
                               
pathCompletedUMaps = getPathCompletedUMaps(pathCompleted, ...
                                           nameData,      ...
                                           uMapType);

% copy data to transfer location
copyData( pathConvertedData, pathCompletedData);

% copy corresponding uMaps to 
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

