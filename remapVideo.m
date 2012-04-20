function outimage = remapVideo(i, image, corners, figN)
    inImage = importdata(['dramchip/' sprintf('%d',i-10) '.jpg'], 'jpg');
    topImage = single(inImage)/255;
    [h,w,c] = size(topImage);
%    topImage = ones(480,640,3);
%    [h,w,c] = size(topImage);


    UV=zeros(4,2);
    XY=zeros(4,2);
    UV=[[corners(1,1), corners(1,2)]',[corners(2,1), corners(2,2)]',[corners(3,1), corners(3,2)]',[corners(4,1), corners(4,2)]']';    % target points
    XY=[[1,1]',[1,w]',[h,w]',[h,1]']';    % source points

    P=esthomog(UV,XY,4);

    mappedIm=zeros(480,640,3);
    v=zeros(3,1);

    for r = 1 : 480
        for c = 1 : 640
            v=P*[r,c,1]';
            y=round(v(1)/v(3));
            x=round(v(2)/v(3));
            if (x >= 1) & (x <= w) & (y >= 1) & (y <= h)
                mappedIm(r,c,:)=topImage(y,x,:);
            end
        end
    end

    outimage = overlay(image, mappedIm);

    if figN > 0
        figure(figN)
        imshow(outimage)
    end
