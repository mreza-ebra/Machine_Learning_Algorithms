function [rimg] = reconstruct_image(labels,centroids,imgSize)
%RECONSTRUCT_IMAGE Reconstruct the image given the labels and the centroids
%
%   input -----------------------------------------------------------------
%   
%       o labels: The labels of the corresponding centroid for each pixel
%       o centroids: All the centroids and their RGB color value
%       o imgSize: Size of the original image for reconstruction
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

% ADD CODE HERE: Reconstruct the image based on the labels on the centroids
% HINT: Apply the two steps you have used to reshape in the opposite order 
% if necessary
rimg=zeros(imgSize);
im2=zeros(imgSize(3),imgSize(1)*imgSize(2));

for i=1:imgSize(3)
    c=centroids(i,:)';
    im2(i,:)=c(labels);
    rimg(:,:,i)=reshape(im2(i,:),[imgSize(1) imgSize(2)]);
end
% END CODE
end
