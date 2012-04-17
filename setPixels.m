function image = setPixels(pixelList)

    image = zeros(480, 640);
    [l, m] = size(pixelList);
    for i = 1 : l
        image(pixelList(i,1),pixelList(i,2)) = 1;
    end
