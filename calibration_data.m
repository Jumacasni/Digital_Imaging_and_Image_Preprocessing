function calibrated_image = calibration_data(image)

    % Read flatfield, dark and bias images
    F01 = imread('flatfield_1.JPG');
    F02 = imread('flatfield_2.JPG');
    F03 = imread('flatfield_3.JPG');

    D01 = imread('dark_1.JPG');
    D02 = imread('dark_2.JPG');
    D03 = imread('dark_2.JPG');

    B01 = imread('bias_1.JPG');
    B02 = imread('bias_2.JPG');
    B03 = imread('bias_3.JPG');

    R = imread(image);
    
    [row col] = size(F01);

    % First step (explained in the documentation)
    meanB = mean2(B01+B02+B03);

    F01 = F01 - meanB;
    F02 = F02 - meanB;
    F03 = F03 - meanB;
    D01 = D01 - meanB;
    D02 = D02 - meanB;
    D03 = D03 - meanB;

    % Second step (explained in the documentation)
    meanD = mean2(D01+D02+D03);

    R = R - meanD;
    F01 = F01 - meanD;
    F02 = F02 - meanD;
    F03 = F03 - meanD;

    % Third step (explained in the documentation)
    F = F01 + F02 + F03;
    F = F - mean2(F) + 1;
    calibrated_image = R./F;
    
    % Show the original image and the calibrated image
    figure, imshowpair(R, calibrated_image, 'montage');
end