function [ ] = prepareUMaps( uMapType,        ...
                             dataVersion,     ...
                             pathDict,        ...
                             pathDixonUMaps,  ...
                             pathCTUMaps,     ...
                             pathOutputUMaps, ...
                             pathRadialVibe )
% prepareUMaps  Execute use or creation of specified uMaps 
%
%   If using an existing uMaps set, the other 
%   existing uMaps sets are removed.
%
%   If creating Radial Vibe uMaps one of two  
%   variations is implemented (NYC or EDI).
%
% gary.smith@ed.ac.uk   06 09 2018
    
disp( ' ' );

    %-------------------------------
    % Use existing uMaps
    if    ( strcmp( uMapType, 'DIX' ) )
    
        disp( ' Using Dixon uMaps ' );
        disp( ' ' );
        
        if(exist(pathCTUMaps,'dir'))
            rmdir(pathCTUMaps,'s');
        end
        
    elseif( strcmp( uMapType, 'CAT'    ) )
    
        disp( ' Using CT uMaps ' );
        disp( ' ' );
        
        if(exist(pathDixonUMaps,'dir'))
            rmdir(pathDixonUMaps,'s');
        end
    %
    %-------------------------------
    % Create uMaps fom Radial Vibes 
    else 
        
        % make folder for created uMaps
        if(~exist(pathOutputUMaps,'dir'))
             mkdir(pathOutputUMaps); 
        end
        
        %-------------------------------
        % NYC uMaps creation
        if    ( strcmp( uMapType, 'NYC'   ) )
    
        disp( ' Creating NYC uMaps ' );
        disp( ' ' );
        
        createUMapsNYC( pathRadialVibe , ...
                        pathOutputUMaps);
        
        %-------------------------------
        % EDI uMaps creation
        elseif( strcmp( uMapType, 'EDI'   ) )
    
        disp( ' Creating EDI uMaps ' );
        disp( ' ' );
        
        createUMapsEDI( dataVersion,     ...
                        pathRadialVibe , ...
                        pathOutputUMaps); 
        else 
            
        disp( '  ' );
        disp( ' Invalid uMapType ' );
        
        % break here
        
        end  
    
        %-------------------------------
        % header preparation method is similar 
        % for both Radial Vibes methods
        prepareUMapsHeaders( pathDixonUMaps,   ...
                             pathOutputUMaps,  ...
                             uMapType,         ...
                             pathDict);    
    
        if(exist(pathDixonUMaps,'dir'))
          rmdir(pathDixonUMaps,'s');
        end
    
        if(exist(pathCTUMaps,'dir'))
            rmdir(pathCTUMaps,'s');
        end
    
    end % if (  strcmp(.....
    
    if(exist(pathRadialVibe,'dir'))
        rmdir(pathRadialVibe,'s');
    end
    
end % function