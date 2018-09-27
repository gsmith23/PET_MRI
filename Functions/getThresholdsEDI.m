function [ low, high ] = getThresholdsEDI( dataVersion )
% getThresholdsEDI() tissue thresholds for data version
%
% gary.smith@ed.ac.uk   11 09 2018
        
switch dataVersion
    
    case 'MR_VB20P'
   
        low  = 101;
        high = 450;
    
    case 'MR_VE11P' 
        
        low  = 64;
        high = 320;
        
    otherwise
        
        error(' Unknown data version');
        
end %  switch

end 

