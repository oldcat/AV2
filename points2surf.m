% Converts a list of points to a surface
%
function surf = points2surf(points)

    dim = size(points);
    
    surf = zeros(1,dim(2),dim(1));
    
    for i = 1:dim(2)
        for j = 1:dim(1)
            surf(1,i,j) = points(j,i);
        end
    end
