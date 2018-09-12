function pathAllScript = getPathAllScript( pathProcessing, nameData )
% getPathAllScript() return path for e7tools batch script 'All'
%
% gary.smith@ed.ac.uk   10 09 2018

folderData     = ['\',nameData];
folderScripts  = [folderData,'-Converted',folderData,'-00'];

pathScripts    = [pathProcessing,folderScripts];
pathAllScript  = [pathScripts,'\Run-99-',nameData,'-00-All'];

end

