% Checks how well a plane fits to the depth data of the pixels selected in the binary image
% allowing for a given tolerance either side. quality of fit is the percentage of points
% that fit the plane.
%
function quality = checkFit(planeParam, fullArea, bin, minX, maxX, minY, maxY, tolerance)
    
    totalPoints = sum(sum(bin));
   
    goodPoints = 0;
    
    % loop through relevant pixels only
    for r = minY:maxY
        for c = minX:maxX
            if bin(r,c) == 1
                dist = abs(getDistFromSurf(planeParam, fullArea(r,c,:)));
                if dist <= tolerance
                    goodPoints = goodPoints+1;
                end
            end
        end
    end
    
    quality = goodPoints/totalPoints;
