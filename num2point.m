% Converts a number to a location in a 2D array
%
function point = num2point(number, dim)
    
    point = zeros(1,2);
    
    point(2) = ceil(number/dim(1));
    point(1) = number - dim(1)*(point(2)-1);
    
    if point(2) > dim(2)
        error('ERROR: Number given was outwith given dimensions')
    end

