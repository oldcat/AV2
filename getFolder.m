function folderBin = getFolder(fgDepths, planeBin, tolerance, numPoints, noise)
    
    qual = 0;

    [minX, maxX, minY, maxY] = getBounds(planeBin); 
    
    bestQual = 0;

    desired = 0.99;
    
    for i = 1:1000
        [qual param] = getBestFit(fgDepths,planeBin,minX,maxX,minY,maxY,tolerance,numPoints,noise);      

        if qual > desired
            break
        elseif qual > bestQual
            bestQual=qual;
        end

        if i == 10
            desired = 0.95;
        elseif i == 100
            desired = 0.9;
        end
    end
    
    
    folderBin = myCleanup(newGetLargest(pointsInPlane(param, fgDepths, tolerance)),3,2);
