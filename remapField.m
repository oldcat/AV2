function outimage = remapField()
    field = importdata('field.jpg', 'jpg');
    [h,w,c] = size(field);

    UV=zeros(4,2);
    XY=zeros(4,2);
    UV=[[41, 129]',[40, 429]',[474, 453]',[476, 89]']';    % target points
    %UV=[[39,16]',[37,604]',[476,605]',[478,15]']';    % target points
    XY=[[1,1]',[1,w]',[h,w]',[h,1]']';    % source points

    P=esthomog(UV,XY,4);    % estimate homography mapping UV to XY

    outimage=zeros(480,640,3);   % destination image
    v=zeros(3,1);

    % loop over all pixels in the destination image, finding
    % corresponding pixel in source image
    for r = 1 : 480
    for c = 1 : 640
      v=P*[r,c,1]';        % project destination pixel into source
      y=round(v(1)/v(3));  % undo projective scaling and round to nearest integer
      x=round(v(2)/v(3));
      if (x >= 1) & (x <= w) & (y >= 1) & (y <= h)
        outimage(r,c,:)=field(y,x,:);   % transfer colour
      end
    end
    end

    figure(1)
    imshow(outimage/255)

    % save transfered image
    %imwrite(uint8(outimage),'remapOutput.jpg','jpg');
