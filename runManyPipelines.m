% Script for executing runPipeline() on multiple data sets 
% and/or with multiple attenuation correction methods. 
%
% Description:
%   This master script is used to control the running of 
%   Siemens PET MRI (or CT) image reconstructions using
%   JSRecon12 and e7_tools.
%
%   Attenuation correction can be applied by: 
%   1) using existing uMaps
%       Dixon (DIX), CT (CAT), ...
%   2) creating uMaps using Radial/STAR Vibes data
%       Edinburgh (EDI), New York (NYU) 
%
% Author:
%   gary.smith@ed.ac.uk   06 09 2018
%
% Requirements:
%   JSRecon12
%       C:\JSRecon12\JSRecon12.js
%       C:\JSRecon12\JSRecon_params  (set prior to running)
%
%   e7_tools
%       C:\Siemens\MRS\*  
%       C:\Siemens\PET\* 
%       C:\Service\*
%
%   DICOM dicionary (required for Radial Vibes method)
%       C:\Docs\dicom-dict-4PETMRI.txt

% Location of data source
pathToData = 'D:\Gary\PETMRI_TestData_B20P_Test2';

% DIX, CAT  - use existing uMaps
% EDI, NYC  - create uMaps from Radial Vibe
%uMapTypeMatrix = ['EDI';'NYC';'DIX'];

uMapTypeMatrix = ['NYC';'DIX'];

nTypes = length(uMapTypeMatrix(:,1));

for iUMapsType = 1:nTypes
    
     runPipeline(uMapTypeMatrix(iUMapsType,:), pathToData);

end
