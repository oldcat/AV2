function [depths, image] = input2image(input)

    resizedIm = reshape(input, 640, 480, 6);
    rotatedIm = imrotate(resizedIm, 90);
    image = flipdim(rotatedIm, 1);
    
    depths = image(:,:,1:3);
    image  = image(:,:,4:6)/255;


