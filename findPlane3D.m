function [newPlaneBin] = findPlane(planeBin)

    for y = 480:-1:1
        if sum(planeBin(y,:) > 0)
            break
        end
    end
    
    total = sum(planeBin(y,:));
    
    for xl = 1:640 
        if sum(planeBin(:,xl) > 0)
            break
        end    
    end
    
    for xr = 640:-1:1
        if sum(planeBin(:,xr) > 0)
            break
        end    
    end

    if(total > 100)
        blCorn = [xl,y];
        brCorn = [xr,y];
    else
        if
    
    end 
    
    newPlaneBin = [xl y xr];
