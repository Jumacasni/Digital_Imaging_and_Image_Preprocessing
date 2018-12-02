%% Measuring intensity of images

function intensity = measuring_intensity(image) 

    % Read the image
    I = imread(image);
    
    % Calibrate the image
    calibrated_image = calibration_data(image);
    
    % Calculate the intensity of the object
    intensity = detect_object(calibrated_image, I);

end