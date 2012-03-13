function main()

    input = importdata('bindermat/xyzrgb_frame_0016.mat');
    image = input2image(input);
    imshow(image(:,:,4:6)/255);

