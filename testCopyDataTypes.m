
 pathFrom = 'D:\Gary\Storage\';
 pathTo   = ['D:\Gary\Bundle1';'D:\Gary\Bundle2'];
 
 tic
 
 for iType = 1:2
     copyDataType(pathFrom,pathTo(iType,:),iType);
     toc
 end
