function [ ] = prepareUMaps( uMapType,         ...
                             dataVersion,      ...
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
%   variations is implemented (NYC or EDI).
%
% gary.smith@ed.ac.uk   10 09 2018
    
disp( ' ' );

switch uMapType
    case 'DX'
        disp( ' Using Dixon uMaps ' );
        disp( ' ' );
        
        if(exist(pathCTuMaps,'dir'))
            rmdir(pathCTuMaps,'s');
        end
        
    case 'CT'
        disp( ' Using CT uMaps ' );
        disp( ' ' );
        
        if(exist(pathDXuMaps,'dir'))
            rmdir(pathDXuMaps,'s');
        end
        
    otherwise % Radial Vibe creation
        
        % make folder for created uMaps
        if(~exist(pathRadVibeUMaps,'dir'))
             mkdir(pathRadVibeUMaps); 
        end
        
        %-------------------------------
        % NYC uMaps creation
        if    ( strcmp( uMapType, 'NY'   ) )
    
        disp( ' Creating NYC uMaps ' );
        disp( ' ' );
        
        createUMapsNYC( pathRadVibeData , ...
                        pathRadVibeUMaps);
        
        %-------------------------------
        % EDI uMaps creation
        elseif( strcmp( uMapType, 'ED'   ) )
    
        disp( ' Creating EDI uMaps ' );
        disp( ' ' );
        
        createUMapsEDI( dataVersion,     ...
                        pathRadVibeData , ...
                        pathRadVibeUMaps); 
        else 
            
        disp( '  ' );
        disp( ' Invalid uMapType ' );
        
        % break here
        
        end  
    
        %-------------------------------
        % header preparation method is similar 
        % for both Radial Vibes methods
        prepareUMapsHeaders( pathDXuMaps,   ...
                             pathRadVibeUMaps,  ...
                             uMapType);    
    
        if(exist(pathDXuMaps,'dir'))
          rmdir(pathDXuMaps,'s');
        end
    
        if(exist(pathCTuMaps,'dir'))
            rmdir(pathCTuMaps,'s');
        end
        
end % switch

    if(exist(pathRadVibeData,'dir'))
        rmdir(pathRadVibeData,'s');
    end

end % function