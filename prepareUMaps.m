function [ ] = prepareUMaps( uMapType,         ...
                             pathDXuMaps,      ...
                             pathCTuMaps,      ...
                             pathRadVibeUMaps, ...
                             pathRadVibeData )
% prepareUMaps  Facilitate use or creation of specified uMaps 
%
%   If using an existing uMaps set, the other 
%   existing uMaps sets are removed from the 
%   Processing folder.
%
%   If creating Radial Vibe uMaps one of two  
%   variations is implemented (NYC/NY or EDI/ED).
%
% gary.smith@ed.ac.uk   11 09 2018
    
disp( ' ' );

switch uMapType
    case 'DX'
        disp( ' Using Dixon uMaps ' );
        disp( ' ' );
        
        rmdirIfExisting(pathCTuMaps);
                
    case 'CT'
        disp( ' Using CT uMaps ' );
        disp( ' ' );
               
        rmdirIfExisting(pathDXuMaps);
        
    otherwise % Radial Vibe creation
        
        mkdirIfAbsent(pathRadVibeUMaps);
                       
        switch uMapType
            case 'NY'  
    
                disp( ' Creating NYC uMaps ' );
                disp( ' ' );
        
                createUMapsNYC( pathRadVibeData , ...
                                pathRadVibeUMaps);
        
            case 'ED' 
    
                disp( ' Creating EDI uMaps ' );
                disp( ' ' );
        
                createUMapsEDI( pathRadVibeData , ...
                                pathRadVibeUMaps); 
            otherwise 
            
            disp( '  ' );
            error( ' Unknown uMapType ' );
        
        end  % switch uMapType (radial vibe) 
    
        % radial vibe header prep
        prepareUMapsHeaders( pathDXuMaps,       ...
                             pathRadVibeUMaps,  ...
                             uMapType);    
    
        rmdirIfExisting(pathDXuMaps);
          
        rmdirIfExisting(pathCTuMaps);
       
        
end % switch uMapType (any)

    rmdirIfExisting(pathRadVibeData);
    

end % function