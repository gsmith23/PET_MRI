function [ ] = createUMapNYC( pathRadVibeData, ...
                              pathRadVibeUMap)
% createUMapNYC() make UMap from Radial VIBE data 
% Transform 3D golden angle Radial VIBE images
% into DICOM UMap to be passed to JSRecon12 
%
% Adapted
% gary.smith@ed.ac.uk   28 09 18
%

codePath = pwd;

addpath( pathRadVibeData, ...
         pathRadVibeUMap );

%--------------------------------
% initialise constants

% FOV of Radial VIBE images [mm] 
FOV = 500;       

% FWHM of uMap smoothing kernel [mm] 
KERNEL_FWHM = 3;    

% linear attenuation coefficients [cm^-1]  
LAC_SOFT_TISSUE = 0.1;    
LAC_FAT         = 0.0854;        

%----------------------
%  Load dicom images
%
%  To Do: change to full paths
cd( pathRadVibeData );  
%inputFileArray = ls('*IMA*');
inputFileArray = ls;

nFiles = size(inputFileArray,1);

% test necessity for this clear
clear ima_in info_in

for iFile = 1:nFiles-2
    
    info_in(iFile) = dicominfo(inputFileArray(2+iFile,:));
    ima_in(:,:,iFile) = dicomread(inputFileArray(2+iFile,:));
    %  No need to correct for slice location as all analysis 
    % (eg smoothing) is done in 2D at present.
end


%  Histogram image to find cut-off thresholds for water and fat

n_bins = 100;  %  

[n,m,q] = size(ima_in);

histoima = hist( double(reshape(ima_in,1,n*m*q)),n_bins );

% Find turning points of histogram 
% (assume a smooth histogram with the 
% first peak representing background, the
% second peak representing soft tissue, and the
% tail representing fat)

%  Assume curve is smooth
d_curve = diff( histoima );

tps = [];   % Turning points on the curve in units of indices of histoima

% To Do: why does this start at 2?
for iFile = 2:length(histoima)-1
    
    curve_diff_back    = d_curve(iFile-1);
    curve_diff_forward = d_curve(iFile);
    
    if ( (curve_diff_back > 0) && (curve_diff_forward <= 0) || ...  % maxima
         (curve_diff_back <= 0) && (curve_diff_forward > 0) )    % minima
        
        tps = [tps,iFile];
        
    end
    
end

%---------------------
%  Create DICOM uMap

% a, b are the thresholds for the water and fat components
% and are fractions of the maximum pixel intensity

a = tps(1)/n_bins;

%  Use b to segment a fat component also -  to be tested.
b = 1;  % Soft tissue component only

%  Assume fat-water contrast is constant and can 
% define water-fat threshold based on background-water threshold.

%  !!! This assumption needs evaluating !!!
% b = (tps(2) + round(1.5*(tps(2)-tps(1))))/n_bins;

cd(codePath)
[soft_tissue, fat] = createUMapRawNYC(ima_in, a, b);  

%  Smooth images
soft_tissue_smooth  = imageSmooth2D(soft_tissue, [FOV FOV], KERNEL_FWHM);
fat_smooth          = imageSmooth2D(fat,         [FOV FOV], KERNEL_FWHM);

umap = (LAC_SOFT_TISSUE / max(max(max(soft_tissue_smooth)))).*soft_tissue_smooth + (LAC_FAT / max(max(max(fat_smooth)))).*fat_smooth;

if (b == 1)
    umap = (LAC_SOFT_TISSUE / max(max(max(soft_tissue_smooth)))).*soft_tissue_smooth;
end

%-------------------------
%  Save dicom series
cd( pathRadVibeUMap ) 

for iFile = 1:size(inputFileArray,1)-2
    
    dicomwrite( uint16(umap(:,:,iFile).*10000) ,       ...
              ['umap_slice_' num2str(iFile) '.dcm'], ...
                info_in(iFile) );
    
end

rmpath( pathRadVibeData, ...
        pathRadVibeUMap );
    
cd(codePath);

end

