% Given an initial flat part described by planeBin find other foreground points that
% exist at depths within that plane. Cleanup output image to give just one area that should
% describe the folder.
%
function folderBin = getFolder(fgDepths, planeBin, tolerance, numPoints, noise)
    
    qual = 0;

    [minX, maxX, minY, maxY] = getBounds(planeBin); 
    
    bestQual = 0;
    bestParam = [0,0,0,0];

    desired = 0.99;
    
    for i = 1:300
        [qual param] = getBestFit(fgDepths,planeBin,minX,maxX,minY,maxY,tolerance,numPoints,noise);      

        if qual > desired
            bestParam = param;
            break
        elseif qual > bestQual
            bestQual=qual;
            bestparam=param;
        end

        if i == 50
            desired = 0.95;
        elseif i == 150
            desired = 0.9;
        end
        if qual > desired
            break
        end        
    end
    
    
    folderBin = myCleanup(newGetLargest(pointsInPlane(bestParam, fgDepths, tolerance)),3,2);
