function [ ] = runPipeline(uMapType, ...
                           pathData)
% runPipeline() execute PET MRI reconstruction pipeline
% 
% ---------------
%
% Description
%
%   This program is used to produce an image reconstruction  
%   for PET MRI data. Input arguments are used to specify 
%   which input data and attenuation correction method to use.
% 
%   The data and uMaps are initially copied to a processing 
%   folder (Processing). 
%
%   If specified a custom uMap is created using methods 
%   provided.
%
%   Once the data and uMaps are prepared JSRecon12 is
%   executed on the data in the processing folder. This 
%   results in the production of e7_tools scripts.
%
%   The e7_tools scripts are then executed which results
%   in the production of image reconstructions.
%
%   The image reconstructions are copied to an output folder
%   (Output) with the corresponding uMaps ready for transfer.
% 
% ---------------
% Input arguments 
%
%   uMapType: 'DIX', 'CAT' - use existing uMaps
%             'EDI', 'NYC'  - create uMaps from Radial Vibes
%
%   pathData: full path to the data and uMaps folders   
%
%
% ---------------
% Author
%
%   gary.smith@ed.ac.uk 04 09 201
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
%   Change pathRecon and pathTrans to 
%   paths relative to 'drive'.
%
%--------------------------


% Dictionary for header file creation
%   To Do: add check for dictionary
pathDict = 'C:\Docs\dicom-dict-4PETMRI.txt';

% uMaps and Radial Vibes
%   To Do:  initialise in runManyPipelines()
%           and pass as argument
nameDixonUMaps  = 'Dixon_umap';
nameCTUMaps     = 'Static-CT';
nameRadialVibe  = 'RadialVIBE';

% Data/scanner version: 'B20' or 'E11';
% required for Radial Vibe EDI 
%   To Do: extract from DICOM header info
dataVersion = 'B20';

%'D:\Gary\Processing';

pathRootFolder = getPathRootFolder(pathData);

% Location for Reconstructing Data
pathProcess = 'Processing';
pathProcess = [pathRootFolder,'\',pathProcess]; 

% Location to Transfer from
pathOutput  = 'Output';
pathOutput  = [pathRootFolder,'\',pathOutput];

% name of raw data folder  
nameData = getNameData(pathData);    

% Paths to data and uMaps
pathDixonUMaps  = setPathUMaps(pathProcess, ...
                               nameData,  ...
                               nameDixonUMaps);
                           
pathCTUMaps     = setPathUMaps(pathProcess, ...
                               nameData,  ...
                               nameCTUMaps);
                           
pathRadialVibe  = setPathRadialVibe(pathProcess, ...
                                    nameData,  ...
                                    nameRadialVibe);
                                
pathOutputUMaps = setPathOutputUMaps(pathProcess,      ...
                                     nameData,       ...
                                     nameRadialVibe, ...
                                     uMapType);

pathReconData  = setPathReconData(pathProcess, ...
                                  nameData);

%--------------------------
%--------------------------
% Execute Pipeline 
%

%--------------------------
% a) Copy raw data and uMaps to reconstruction location

copyData(pathData,  ...
         pathReconData);

%--------------------------     
% b) Prepare custom uMaps
prepareUMaps(uMapType,        ...
             dataVersion,     ...
             pathDict,        ...
             pathDixonUMaps,  ...
             pathCTUMaps,  ...
             pathOutputUMaps, ...
             pathRadialVibe);   

%--------------------------         
% c) Execute reconstruction process
runReconstruction(pathProcess,nameData);

%--------------------------
% d) Copy the reconstructed data,  
%    and umaps to the destination

pathConvertedData = setPathConvertedOP(pathProcess, ...
                                       nameData);

pathTransData  = setPathTransData(pathOutput, ...
                                  nameData,  ...
                                  uMapType);
                                
pathTransUMaps = setPathTransUMaps(pathOutput, ...
                                   nameData,  ...
                                   uMapType);

% copy data to transfer location
copyData( pathConvertedData, pathTransData);

% clean up ready for next pipeline
rmdir(pathConvertedData,'s');

% copy corresponding uMaps to 
% transfer location

if    (strcmp(uMapType,'DIX'))
    
    copyData( pathDixonUMaps, pathTransUMaps);
    
elseif(strcmp(uMapType,'CAT'))  
    
    copyData( pathCTUMaps, pathTransUMaps);

% Radial VIBE uMap
else
    copyData( pathOutputUMaps, pathTransUMaps);
end

% clean up ready for next pipeline
rmdir(pathProcess,'s');        

end

