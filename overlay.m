function outimage = overlay(xyzrgb, mappedIm)

    [a, b, c] = size(xyzrgb);
    [h, w, l] = size(mappedIm);

    outimage = zeros(a,b,l);

    for i = 1 : a
        for j = 1 : b
            if mappedIm(i,j,1) == 0 & mappedIm(i,j,2) == 0 & mappedIm(i,j,3) == 0
                outimage(i,j,:) = xyzrgb(i,j,1:3);
            else
                outimage(i,j,:) = mappedIm(i,j,:);
            end
        end
    end
