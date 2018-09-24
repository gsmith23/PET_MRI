function pathToReady = getPathToReady( location )
% getPathToReady() return preset value of full path to folder/s of data.
%   

    switch location
       % Reporting Room
       case 'R'
           pathToReady = 'D:\Gary_RR\Ready\';
       % Laptop
       case 'L'
           pathToReady = 'C:\Data\JSRecon12-TestData\Ready\';
       % E7Tools PC
       case 'E'
           pathToReady = 'F:\Gary_E7\Ready\';
        otherwise
           error(' Invalid location ');
    end 

end

