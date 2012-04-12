function image = setPixels(pixelList)

    image = zeros(640, 480);
    [l, m] = size(pixelList);
    for i = 1 : l
        image(pixelList(i,1),pixelList(i,2)) = 1;
    end
