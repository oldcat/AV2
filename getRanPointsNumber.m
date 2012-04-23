% get a number of random point references from a total number of points
%
function [points] = getRanPointsNumber(totalPoints, numPointsToReturn)
    
    if(numPointsToReturn > totalPoints || numPointsToReturn <= 0)
        error('ERROR: number of points must be between 0 and the total points')
    end
    
    N = numPointsToReturn;

    points = [ceil(rand*totalPoints)];
    
    for i = 2:N
        i;
        point = ceil(rand*(totalPoints-i+1));
        
        for j = 1:(i-1)
            if (point < points(j));
                break
            else
                point = point + 1;
                if j == i-1
                    j = j+1;
                end
            end
        end
        points = [points(1:j-1) point points(j:end)];
    end
