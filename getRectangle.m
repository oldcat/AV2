function [rect] = getRectangle(manBin, depthPts)

    boxDim = 

    dim = size(manBin)

    % find bounding box of man
    
    for r = 1:dim(1)
        if sum(manBin(r,:)) > 0
            minY = r;
            break;
        end
    end
    
    for r = dim(1):-1:1
        if sum(manBin(r,:)) > 0
            maxY = r;
            break;
        end
    end
    
    for c = 1:dim(2)
        if sum(manBin(:,c)') > 0
            minX = c;
            break;
        end
    end
    
    for c = dim(2):-1:1
        if sum(manBin(:,c)') > 0
            maxX = c;
            break;
        end
    end
    
    for boxR = minY:(maxY - boxD(1))
        for boxC
