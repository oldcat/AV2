% Converts a surface to a list of points
%
function points = surf2points(surf)

    dim = size(surf);
    
    points = zeros(dim(3),dim(1)*dim(2));
    
    count = 1;
    for i = 1:dim(1)
        for j = 1:dim(2)
            for k = 1:dim(3)
                points(k,count) = surf(i,j,k);
            end
            count = count+1;
        end
    end
