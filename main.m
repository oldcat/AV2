function main()

    [bgDepths, bgIm] = getBackground;

    for i = 1:36
        filename = ['bindermat/xyzrgb_frame_' sprintf('%04d', i) '.mat'];
    
        [fgDepths, fgIm] = input2image(importdata(filename));
        
        %figure(1)
        %imshow(bgIm)
        %figure(2)
        %imshow(fgIm)
        
        newDepth = abs(bgDepths(:,:,3) - fgDepths(:,:,3));
           
        showable = newDepth-min(min(newDepth));
        
        showable = showable/max(max(showable));

        %figure(3)
        %imshow(showable);

        %figure(4)
        %hist(showable(:),200);
        
        better = showable .* double(showable<0.5);
        better = better-min(min(better));
        better = better/max(max(better));
        
        %figure(5)
        %imshow(better);
           
        %figure(6)
        manInIm = zeros(480, 640, 3);
        % put in background
        bgBin = (showable<0.07) | (showable>0.3);
        manInIm(:,:,1) = bgIm(:,:,1) .* double(bgBin);
        manInIm(:,:,2) = bgIm(:,:,2) .* double(bgBin);
        manInIm(:,:,3) = bgIm(:,:,3) .* double(bgBin);
        
        % put in foreground
        manInIm(:,:,1) = manInIm(:,:,1) + (fgIm(:,:,1) .* double(~bgBin));
        manInIm(:,:,2) = manInIm(:,:,2) + (fgIm(:,:,2) .* double(~bgBin));
        manInIm(:,:,3) = manInIm(:,:,3) + (fgIm(:,:,3) .* double(~bgBin));
           
           
        figure(i) 
        imshow(manInIm)
        
end
