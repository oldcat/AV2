function main()

    background = input2image(importdata('bindermat/xyzrgb_frame_0001.mat'));
    foreground = input2image(importdata('bindermat/xyzrgb_frame_0016.mat'));
    
    
    
    size(background)
    size(foreground)
    
    newDepth = abs(background(:,:,1:3) - foreground(:,:,1:3));
    
    inIm = newDepth(123,260,3)
    gap  = newDepth(108,355,3)
    
    showable = newDepth(:,:,3)-min(min(newDepth(:,:,3)));
    
    showable = showable/max(max(showable));

    imshow(showable);


    figure(2)
    hist(showable(:),200)
    
    better = showable .* double(showable<0.5);
    better = better-min(min(better));
    better = better/max(max(better));
    
    figure(3)
    imshow(better);
