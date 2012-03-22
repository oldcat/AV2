vw = VideoWriter('AV_movie.avi');
vw.FrameRate = 6;
vw.open();

for i = 1 : 36
  image = output_images{i}; 
  imshow(uint8(image));
  writeVideo(vw,getframe(gcf));
end
close(vw); 
