
 pathFrom = 'C:\Data\JSRecon12-TestData\Completed';
 pathTo   = 'E:\';
 
 tic
 
 for iType = 1:2
     copyDataType(pathFrom,pathTo,iType);
     toc
 end
