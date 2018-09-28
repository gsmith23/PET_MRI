function [] = prepareUMapHeaders( pathDixonUMap,   ...
                                  pathCreatedUMap,  ...
                                  uMapType)
% prepareUMapHeaders() customise header info using Dixon header and dictionary
% This is necessary for consistency with scanner UMap.
%
% gary.smith@ed.ac.uk   10 09 2018
%
% pathDixonUMap   - absolute path to Dixon UMap 
% pathCreatedUMap - absolute path of Created UMap
% uMapType        - 'ED','NY' (Radial Vibe) or 'CT' 
% Note that no StarVibe text has not been included
%
% Known issues - warnings are given for dicomwrite, this appears to cause
% no issues and is a known bug in Matlab. Warnings have been silenced.

codePath = pwd;

addpath( pathDixonUMap, ...
         pathCreatedUMap );
     
% Dictionary for header file creation
%   To Do: add check for dictionary
pathDict = 'C:\Docs\dicom-dict-4PETMRI.txt';

disp( ' Using dicom dictionary... ' );
disp( ['   ', pathDict] );
disp( ' ' );

% Folder of original Dixon UMap
cd( pathDixonUMap );

% change 
dixonUMapArray = ls('*.IMA');

% Folder for created Radial Vibe or CT UMap
cd( pathCreatedUMap );

radialVibeUMapArray = ls('*.dcm');

if( ~strcmp(uMapType, 'CT'))
        disp(' preparing Radial Vibe header');
        disp( ' ' );
else
        disp(' preparing CT header');
        disp( ' ' );
end

% TEMPORARY - switch off the warnings
warning('off','images:dicom_add_attr:wrongAttribNum')

for iFile=1:size(radialVibeUMapArray,1)  
    
    % Dixon header as input
    info_in = dicominfo(radialVibeUMapArray(iFile,:));
      
    info_umap = dicominfo(dixonUMapArray(iFile,:)); 
    
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
      
    ima_in = dicomread(radialVibeUMapArray(iFile,:));
     
    dicomwrite(ima_in,                          ...
               radialVibeUMapArray(iFile,:),   ...
               info_in,                         ...
               'WritePrivate',                  ...
                true,                           ...
               'dictionary',                    ...
                pathDict);

end

rmpath( pathDixonUMap, ...
        pathCreatedUMap );
     
cd( codePath );

end