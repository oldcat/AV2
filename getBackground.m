% Returns the depths and image from the first frame as background
%
function [depths, outim] = getBackground()

    input = importdata('bindermat/xyzrgb_frame_0001.mat');
    [depths, image] = input2image(input);
    outim = overlay(image, remapField);
