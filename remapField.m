% Loads the field image and remaps it, using a homographic 
% transfer, to the necessary coordinates for it to be 
% subsequently overlaid onto another image

function outimage = remapField()
    field = importdata('field.jpg', 'jpg');
    [h,w,c] = size(field);

    UV=zeros(4,2);
    XY=zeros(4,2);
    UV=[[41, 129]',[40, 429]',[474, 453]',[476, 89]']';
    XY=[[1,1]',[1,w]',[h,w]',[h,1]']';

    P=esthomog(UV,XY,4);

    outimage=zeros(480,640,3);
    v=zeros(3,1);

    for r = 1 : 480
        for c = 1 : 640
            v=P*[r,c,1]';
            y=round(v(1)/v(3));
            x=round(v(2)/v(3));
            if (x >= 1) & (x <= w) & (y >= 1) & (y <= h)
                outimage(r,c,:)=field(y,x,:);
            end
        end
    end

    outimage = outimage/255;
