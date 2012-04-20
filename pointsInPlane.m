function [bin] = pointsInPlane(surfParam, depthPts, tolerance)

    dim = size(depthPts);
    
    bin = zeros(dim(1),dim(2));
    
    for r = 1:dim(1)
        for c = 1:dim(2)
            dist = abs(getDistFromSurf(surfParam, depthPts(r,c,:)));
            if dist <= tolerance
                bin(r,c) = 1;
            end
        end
    end
