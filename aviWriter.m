function aviWriter(images);

    vw = VideoWriter('AV_movie.avi');
    vw.FrameRate = 25;
    vw.open();

    for i = 1 : 36
      image = images{i};
      imshow(image);
      writeVideo(vw,getframe);
    end
    close(vw); 
