function [labels, centroids] = compress_image(img,K,init,type,MaxIter)
%COMPRESS_IMAGE Compress the image using k-means
%
%   input -----------------------------------------------------------------
%   
%       o img      : (height x width x 3), the image to cluster
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'random','uniform'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations

%
%   output ----------------------------------------------------------------
%
%       o labels    : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o centroids : (3 x k), centroid of the clusters (corresponds to Mu
%                     returned by k-means


% ADD CODE HERE
imgSize = size(img);
im2=zeros(imgSize(3),imgSize(1)*imgSize(2));
% HINT: reshape the img data to get 3x(width*height) array prior to call 
% k-means. Be carefull about the way reshaping works
for i=1:imgSize(3)
    im2(i,:)=reshape(img(:,:,i),[1 imgSize(1)*imgSize(2)]);
end
    
[labels, centroids,~,~] =  my_kmeans(im2,K,init,type,MaxIter,[]);
% END CODE
end

