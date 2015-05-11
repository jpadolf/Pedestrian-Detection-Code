function votes = HOG_Vote(intensity,direction,bins)
% Assumptions: 
% Unsigned gradient - channels only go from 0-180
imsize = size(intensity);
votes = zeros(size(bins));
for i=1:imsize(1)
    for j=1:imsize(2)
        [~,bin_index] = min(abs(direction(i,j)-bins)); % which bin?
        votes(bin_index) = votes(bin_index) + intensity(i,j); % vote with gradient intensity
    end
end