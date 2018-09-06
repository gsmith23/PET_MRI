function [] = prepareUMapsHeaders( pathDixonUMaps,   ...
                                   pathOutputUMaps,  ...
                                   uMapType,         ...
                                   pathDict)
% prepareUMapsHeaders() customise header info using Dixon header and dictionary
%
% gary.smith@ed.ac.uk   06 09 2018
%
% pathDixonUMaps  - absolute path to Dixon UMaps 
% pathOutputUMaps - absolute path for UMaps header destination
% uMapType        - 'EDI','NYC' (Radial Vibe) or 'CT' 
%
% Known issues - warnings are given for dicomwrite, this appears to cause
% no issues and is a known bug in Matlab. Warnings have been silenced.

codePath = pwd;

addpath( pathDixonUMaps, ...
         pathOutputUMaps );

disp( ' Using dicom dictionary... ' );
disp( ['   ', pathDict] );
disp( ' ' );

% Folder of original Dixon uMaps
cd( pathDixonUMaps );

% change 
dixonUMapsArray = ls('*.IMA');

% Folder for created Radial Vibe or CT uMaps
cd( pathOutputUMaps );

radialVibeUMapsArray = ls('*.dcm');

if( ~strcmp(uMapType, 'CT'))
        disp(' preparing Radial Vibe header');
        disp( ' ' );
else
        disp(' preparing CT header');
        disp( ' ' );
end

% TEMPORARY - switch off the warnings
warning('off','images:dicom_add_attr:wrongAttribNum')

for iFile=1:size(radialVibeUMapsArray,1)  
    
    % Dixon header as input
    info_in = dicominfo(radialVibeUMapsArray(iFile,:));
      
    info_umap = dicominfo(dixonUMapsArray(iFile,:)); 
    
    % Requirement of e7_tools
    info_in.ImageType = [info_in.ImageType '\MRPET_UMAP3D'];
   
    % Add line to MR uMap header (not CT uMap header)
    if( ~strcmp(uMapType, 'CT'))
        info_in.ProtocolName = [info_in.ProtocolName 'RadialVibeUMAP'];  
    end
    
    info_in.Private_0029_10xx_Creator = info_umap.Private_0029_10xx_Creator;
    info_in.Private_0029_11xx_Creator = info_umap.Private_0029_11xx_Creator;
    info_in.Private_0019_10xx_Creator = info_umap.Private_0019_10xx_Creator; 

    info_in.Private_0051_10xx_Creator = info_umap.Private_0051_10xx_Creator;
    
    info_in.Private_0029_1008 = info_umap.Private_0029_1008;
    info_in.Private_0029_1009 = info_umap.Private_0029_1009;
    info_in.Private_0029_1010 = info_umap.Private_0029_1010;
    info_in.Private_0029_1018 = info_umap.Private_0029_1018;
    info_in.Private_0029_1019 = info_umap.Private_0029_1019;
    info_in.Private_0029_1020 = info_umap.Private_0029_1020;
   
    info_in.Private_0019_1008 = info_umap.Private_0019_1008;
    info_in.Private_0019_1009 = info_umap.Private_0019_1009;
    info_in.Private_0019_1011 = info_umap.Private_0019_1011;
    info_in.Private_0019_1012 = info_umap.Private_0019_1012;
    info_in.Private_0019_1013 = info_umap.Private_0019_1013;
    info_in.Private_0019_1014 = info_umap.Private_0019_1014;
    info_in.Private_0019_1015 = info_umap.Private_0019_1015;
    info_in.Private_0019_1017 = info_umap.Private_0019_1017;
    info_in.Private_0019_1018 = info_umap.Private_0019_1018;
    
    info_in.Private_0051_1008 = info_umap.Private_0051_1008;
    info_in.Private_0051_1009 = info_umap.Private_0051_1009;
    info_in.Private_0051_1012 = info_umap.Private_0051_1012;
    info_in.Private_0051_1013 = info_umap.Private_0051_1013;
    info_in.Private_0051_1016 = info_umap.Private_0051_1016;
    info_in.Private_0051_1017 = info_umap.Private_0051_1017;
    info_in.Private_0051_1019 = info_umap.Private_0051_1019;
      
    ima_in = dicomread(radialVibeUMapsArray(iFile,:));
     
    dicomwrite(ima_in,                          ...
               radialVibeUMapsArray(iFile,:),   ...
               info_in,                         ...
               'WritePrivate',                  ...
                true,                           ...
               'dictionary',                    ...
                pathDict);

end

rmpath( pathDixonUMaps, ...
        pathOutputUMaps );
     
cd( codePath );

end