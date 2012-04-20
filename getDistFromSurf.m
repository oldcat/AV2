function dist = getDistFromSurf(surfParam, point);

    dist = abs(surfParam(1)*point(1) + surfParam(2)*point(2) + surfParam(3)*point(3) - surfParam(4));
    dist = dist/sqrt(surfParam(1)^2 + surfParam(2)^2 + surfParam(3)^2);
