function mean_intensity = detect_object(calibrated_image, original_image)
        
    % Calculate the threshold
    threshold = graythresh(calibrated_image);
    
    % Binarize the image
    gray_image = rgb2gray(calibrated_image);
    BW = imbinarize(gray_image, threshold);
    invBW = imcomplement(BW);
    
    % Show the calibrated image and the binary image
    figure, imshowpair(calibrated_image,invBW, 'montage');
    
    % Calculate the area of the object, so we can detect the object in
    % order to create a rectangle bound around the object.
    stats = regionprops('table',invBW,'Centroid',...
        'Area');
    statsStruct = regionprops(invBW);
    v = table2array(stats);
    areaArray = v(:,1);
    [M I] = max(areaArray);
    
    % Create a bounding box around the object
    rectangle('Position',statsStruct(I).BoundingBox,'EdgeColor','g','LineWidth',2)
    
    % Calculate the mean of intensity
    count = 1;
    
    for i=1:size(original_image,1)
        for j=1:size(original_image,2)
            if (BW(i,j) == 0)
                intensity(count) = original_image(i,j);
                count = count + 1;
            end
        end
    end
    
    mean_intensity = mean(intensity);

end