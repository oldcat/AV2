function Z = tmpGetZ(surfParam, X, Y)

    Z = (surfParam(4) - (surfParam(1)*X) - (surfParam(2)*Y))/surfParam(3);
