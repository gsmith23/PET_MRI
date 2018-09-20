% timing test routine for copyDataType() 

profile on

 %pathFrom   = 'R:\Storage\905MB_Data';
 %pathRootTo = 'F:\Gary_E7\'; 
 
 pathFrom   = 'F:\Gary_E7\Storage\PETMRI_TestData_E11P';
 pathRootTo = 'F:\Gary_E7\Ready\';
  
 % extract source folder name
 [~, nameFolder , ~] = fileparts(pathFrom);
   
 nTypes = 2;
 
 % initialise timing array
 timeArray(nTypes+1) = zeros;
  
 
 for iType = 1:nTypes
    
    % accommodate 'zeroth' entry for elapsedTime()
    iTime = iType + 1;
    
    % destination path with iType in name    
    pathTo = [pathRootTo, nameFolder,'_',int2str(iType)];
    
    %  start counter
    tStart = tic;
    
    copyDataType(pathFrom,pathTo,iType);
    
    % stop counter and record
    elapsedTime  = toc(tStart);
    
    timeArray(iTime) = elapsedTime;
 end
    
 disp( '    ');
 disp( ' Transfer Time Results  ');
 for iTime = 2 : 3
    disp( ['    Type ', num2str(iTime-1) , ' - ' , num2str(timeArray(iTime)) ,' s '] );
 end

 
 profile viewer
 