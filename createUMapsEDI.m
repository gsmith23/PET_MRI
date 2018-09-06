function [ ] = createUMapsEDI( dataVersion,    ...
                               pathRadialVibe, ...
                               pathOutputUMaps)
% createUMapsEDI() Use Radial Vibes data to create uMaps
%   dataVersion is used to dictate thresholds
% 
% gary.smith@ed.ac.uk   04 09 2018
%
% Notes: extract data version from DICOM 
%        to reduce number of i/p arguments   

codePath = pwd;

% To do - use full paths to file names
%         to prevent having to cd
addpath( pathRadialVibe, ...
         pathOutputUMaps );

%---------------------
%  set thresholds
if    ( strcmp(dataVersion,'B20' ))
    
    tissueLow  = 101;
    tissueHigh = 450;
    
elseif( strcmp(dataVersion,'E11') )
    
    tissueLow  = 64;
    tissueHigh = 320;
    
end

% Create array of radial vibe files
% To do: change to full file paths
cd(pathRadialVibe);
inputFileArray = ls('*IMA*');

% To do: test requirement for clear
clear ima_in info_in

% Path where created uMaps will go
% To do: change to full file paths
cd( pathOutputUMaps ); 
   
nFiles = size(inputFileArray,1);

% To Do: Initialise variables outside of loop
%        ima_in, image_threshold, BW, mask        

for iFile = 1:nFiles
        
    info_in(iFile) = dicominfo(inputFileArray(iFile,:));
    
    % read radial vibe images
    ima_in(:,:,iFile) = dicomread(inputFileArray(iFile,:)); 
    
    % initialise to existing thresholds
    image_threshold(:,:,iFile) = ima_in(:,:,iFile);
    
    % Threshold for tissue
    image_threshold( tissueLow < ima_in < tissueHigh) = 1000;   
    
    % Threshold for fat
    image_threshold( ima_in > tissueHigh) = 854;
    
    % Threshold for lung
    image_threshold( ima_in < tissueLow) = 224; 
    
    BW(:,:,iFile) = imbinarize( image_threshold(:,:,iFile) );
    
    % set mask to define patient anatomy
    mask(:,:,iFile) = imfill(BW(:,:,iFile), 'holes');  
    
    % Set attenuation coefficient outside mask to zero
    image_threshold(~mask) = 0;    
    
    dicomwrite( uint16(image_threshold(:,:,iFile)),    ...
                ['umap_slice_' num2str(iFile) '.dcm'], ...
                info_in(iFile),                        ...
                'CreateMode',                      ...
                'copy'); 
    
end

rmpath( pathRadialVibe, ...
        pathOutputUMaps );
     
cd( codePath );

end

