function [planeBin] = newFindPlane3D(fgBin, depthPts, numPoints, searchDim)

    if nargin < 3
        numPoints = 3;
    end
    
    if nargin < 4
        searchDim = 50;
    end    

    fitTolerance = 0.01;
    noise = 0.002;

    dim = size(fgBin);
    
    [minX maxX, minY, maxY] = getBounds(fgBin);
    
    planeBin = zeros(dim);
    bestQual = 0;
   
    
    if (minX > 0)
        for r = 250:(searchDim/2):(maxY-searchDim)
            for c = minX:(searchDim/2):(maxX-searchDim)
                if fgBin(r:(r+searchDim-1),c:(c+searchDim-1)) == ones(searchDim)
                    tmpBin = zeros(dim(1),dim(2));
                    tmpBin(r:(r+searchDim-1),c:(c+searchDim-1)) = ones(searchDim);
                    qual = getBestFit(depthPts,tmpBin,minX,maxX,minY,maxY,fitTolerance,numPoints,noise);
                    % qual = getBestFit(depthPts(r:(r+searchDim-1),c:(c+searchDim-1),:),0.01,numPoints,noise) 
                    if qual > 0.9
                        planeBin = planeBin | tmpBin;
                        bestQual = qual;
                    end                        
                end
            end
        end
    end
    
    planeBin = newGetLargest(planeBin);
    
