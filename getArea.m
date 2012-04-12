function pixelCount = getArea(binaryIm)

    [h,w] = size(binaryIm);
    pixelCount = 0;
    for x = 1:h
        for y = 1:w
            if binaryIm(x,y) == 1
                pixelCount = pixelCount + 1;
            end
        end
    end

