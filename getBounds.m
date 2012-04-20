% Takes a binary image and returns the bounds of the image contained within
% 
% Input parameters:
%
%   binIm - Binary image
%
% Output parameters:
%
%   minX, maxX - The first and last columns that contain any of the foreground
%   minY, maxY - The first and last rows that contain any of the foreground
%
function [minX, maxX, minY, maxY] = getBounds(binIm)

    dim = size(binIm);

    minX = -1;
    maxX = -1;

    for c1 = 1:dim(2)
        if (sum(binIm(:,c1)') > 0)
            minX = c1;
            break;
        end
    end
    
    if c1 <= dim(2)
        for c2 = dim(2):-1:c1
            if (sum(binIm(:,c2)') > 0)
                maxX = c2;
                break;
            end
        end
    end
    
    minY = -1;
    maxY = -1;
    
    for r1 = 1:dim(1)
        if (sum(binIm(r1,:)) > 0)
            minY = r1;
            break;
        end
    end
    
    if r1 <= dim(1)
        for r2 = dim(1):-1:r1
            if (sum(binIm(r2,:)) > 0)
                maxY = r2;
                break;
            end
        end
    end
