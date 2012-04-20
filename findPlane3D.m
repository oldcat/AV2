function [rectBin] = findPlane3D(manBin, depthPts)

    boxDim = 40;
    qualTol = 0.99;
    fitTol = 100000;

    dim = size(manBin);

    % find bounding box of man
    
    minY = -1;
    
    for r = 1:dim(1)
        if sum(manBin(r,:)) > 0
            minY = r
            break;
        end
    end
    
    if minY == -1
        fprintf('No man :(\n');
        rectBin = zeros(dim);
    else
        for r = dim(1):-1:1
            if sum(manBin(r,:)) > 0
                maxY = r
                break;
            end
        end
        
        for c = 1:dim(2)
            if sum(manBin(:,c)') > 0
                minX = c
                break;
            end
        end
        
        for c = dim(2):-1:1
            if sum(manBin(:,c)') > 0
                maxX = c
                break;
            end
        end
        
        boxR = minY;
        boxC = minX;
        notFound = 1;
        biggestBin = zeros(dim);
        
        % loop through image area checking to see if we have a flat plane
        while notFound & ((boxR + boxDim - 1) <= maxY)
                    
            % if box is entirely within the are we have found to be the man        
            if sum(sum(manBin(boxR:boxR+boxDim-1,boxC:boxC+boxDim-1))) >= (boxDim^2)
                
                % select only the points in the current area                
                curArea = depthPts(boxR:boxR+boxDim-1,boxC:boxC+boxDim-1,:);                
                
                % Get the quality of the best fit plane found to the surface being analysed
                quality = getBestFit(curArea,fitTol,10,0.01)
                
                % if fit is good enough grow area
                %if quality >= qualTol
                    fprintf('I got here')
                %    areaBin = growArea(manBin, depthPts, boxR, boxC, boxDim, qualTol, fitTol);
                    areaBin = zeros(dim);
                    for r = 1:dim(1)
                        for c = 1:dim(2)
                            if (r >= boxR) & (r <= boxR+boxDim-1) & (c >= boxC) & (c <= boxC+boxDim-1)
                                areaBin(r,c) = 1;
                            end
                        end
                    end
                    if sum(sum(areaBin)) >= sum(sum(biggestBin))
                        biggestBin = biggestBin | areaBin;
                    end
                %end 
            end

            % update loop counters
            boxC = boxC + boxDim;
            if (boxC + boxDim - 1) > maxX
                boxC = minX;
                boxR = boxR + boxDim;
            end
        end
        rectBin = biggestBin;
    end        
        
    %    for boxR = minY:boxDim/2:(maxY - boxDim)
    %        for boxC = minX:boxDim/2:(maxX - boxDim)

