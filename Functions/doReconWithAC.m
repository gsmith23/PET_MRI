function doReconWithAC(uMapType, ...
                       pathToData)
% doReconWithAC() do reconstruction for one PET scan using one AC method
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
%   uMapType: 'DX', 'CT', e.g. - use existing uMaps
%             'ED', 'NY' - create uMaps from Radial Vibes
%
%   pathToData: full path to the folder containing data folder/s 
%               and uMap folder/s   
%
% ---------------
% Author
%
%   gary.smith@ed.ac.uk     28 09 2018
%
                                
%-------------------------------------------------
%-------------------------------------------------
                                   
%--------------------------
%--------------------------
% Execute Reconstruction Process 
%
%--------------------------
% a) Copy raw data and uMap to Processing 
%    folder: location where reconstruction
%    will be performed

copyDataToProcessing(uMapType, ...
                     pathToData);
       
%--------------------------     
% b) Create uMap if necessary
%
if( strcmp(uMapType,'ED') || ...
    strcmp(uMapType,'NY') )

    createUMap(uMapType, ...
               pathToData);  
  
end

%--------------------------         
% c) Execute reconstruction process
runReconstruction(pathToData);

%--------------------------
% d) Copy the reconstructed data,  
%    and umaps to the Completed
%    folder ready for transfer
copyConvertedData( uMapType, ...
                   pathToData );

% e) Clean up ready for next pipeline
% To Do: add check for permissions, 
% pause with message if no 'write'.

deleteProcessingFolder(pathToData);       

end