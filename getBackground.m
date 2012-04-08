function outim = getBackground

    input = importdata('bindermat/xyzrgb_frame_0001.mat');
    image = input2image(input);
    outim = overlay(image, remapField);
    outim/255;
