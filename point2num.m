function number = point2num(point, dim)

    if (point(1) > dim(1)) | (point(2) > dim(2))
        error('ERROR: Given point outside of given dimensions')
    end

    number = (point(2)-1)*dim(1) + point(1);
