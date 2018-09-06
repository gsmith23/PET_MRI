function pathAllScript = setPathAllScript( pathRecon, nameData )
% setPathAllScript sets path for e7tools batch script 'All'

folderData     = ['\',nameData];
folderScripts  = [folderData,'-Converted',folderData,'-00'];

pathScripts    = [pathRecon,folderScripts];
pathAllScript  = [pathScripts,'\Run-99-',nameData,'-00-All'];

end

