function quality = checkFit(surfParam, fullArea, bin, minX, maxX, minY, maxY, tolerance)
    
    totalPoints = sum(sum(bin));
   
    goodPoints = 0;
    
    for r = minY:maxY
        for c = minX:maxX
            if bin(r,c) == 1
                dist = abs(getDistFromSurf(surfParam, fullArea(r,c,:)));
                if dist <= tolerance
                    goodPoints = goodPoints+1;
                end
            end
        end
    end
    
    quality = goodPoints/totalPoints;
