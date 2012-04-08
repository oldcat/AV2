function [newPlaneBin] = findPlane(planeBin)

    for y = 480:-1:1
        if sum(planeBin(y,:) > 0)
            break
        end
    end
    
    newPlaneBin = y;
