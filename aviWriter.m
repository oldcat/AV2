% Takes a cell array of images and writes a video with the
% images as frames.
%
function aviWriter(images);

    vw = VideoWriter('AV_movie.avi');
    vw.FrameRate = 6;
    vw.open();

    for i = 1 : 36
      image = images{i};
      imshow(image);
      writeVideo(vw,getframe);
    end
    close(vw); 
