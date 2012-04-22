function [bestQual bestParam] = getBestFit(fullArea,bin,minX,maxX,minY,maxY,fitTol,numPoints,noise)

    runs = 10;

    dim = size(fullArea);
    surfacePoints = sum(sum(bin));

    bestQual = 0;

    % Number of runs calculated using equation from
    % http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/FISHER/RANSAC/
    % with the following parameters:
    %
    %       pfail    = 0.0001
    %       N        = 3      = numPoints
    %       psuccess = 0.87     (estimated from contour plots)
    %
    for i = 1:20
        randP = getRanPointsNumber(surfacePoints,numPoints);
               
        points = [];
        
        for p = 1:numPoints
            pos = num2PosBin(randP(p), bin, minY, maxX);
            point = fullArea(pos(1),pos(2),:);
            points = [points [point(1); point(2); point(3)]];
        end
        
        [A, B, C, D] = getFit(points, noise);
        
        quality = checkFit([A, B, C, D], fullArea, bin, minX, maxX, minY, maxY, fitTol);
        %fprintf('Run: %03d\tQuality:%4.2f\n',i,quality);
        
        if quality > bestQual
            bestQual = quality;
            bestParam = [A B C D];
        end
        
        if quality == 1
            break;
        end
    end
    
    bestQual;
