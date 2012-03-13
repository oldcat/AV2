function [image] = input2im(input)

    image = zeros(480,640,6);

    inputPos = 1
    for c = 1:640
       for r = 1:480          
            image(r,c,:) = input(inputPos,:);
            inputPos = inputPos + 1;
        end
    end
            
