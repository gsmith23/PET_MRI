function pathToFolders = getPathToFolders( location )
% getPathToFolders() return preset value of full path to folder/s of data.
%   
 
     switch location
       % Reporting Room
       case 'R'
           pathToFolders = 'D:\Gary_RR\Ready\';
       % Laptop
       case 'L'
           pathToFolders = 'C:\Data\JSRecon12-TestData\Ready\';
       % E7Tools PC
       case 'E'
           pathToFolders = 'F:\Gary_E7\Ready\';
        otherwise
           error(' Invalid location ');
    end 

end

