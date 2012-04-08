function outim = getBackground

    input = importdata('bindermat/xyzrgb_frame_0001.mat');
    outim = input2image(input);
