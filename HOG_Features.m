function features = HOG_Features(img,cell_size,block_size,overlap,channels)
tic
I = im2double(img);
imsize = size(I);
figure(1), hold on; %imshow(I); hold on;
bins = 0:pi/channels:pi-pi/channels;
BlocksPerImage = (imsize(2)-overlap*cell_size)/((block_size-overlap)*cell_size) * ...
(imsize(1)-overlap*cell_size)/((block_size-overlap)*cell_size);
features = zeros(1,BlocksPerImage * channels * block_size^2);

%% Calculate gradient intensity and direction
hx = [-1 0 1];
hy = [-1;0;1];

Gx = imfilter(I,hx,'replicate'); % horizontal gradients
Gy = imfilter(I,hy,'replicate'); % vertical gradients

Gi = hypot(Gx,Gy); % gradient intensity
Gtheta = atan2(Gx,Gy); % gradient direction
Gtheta(Gtheta<0) = Gtheta(Gtheta<0) + pi; % ignore sign of direction

% h = fspecial('Gaussian', block_size*cell_size, 0.5*block_size);

%% Create Blocks
i=1;
for ib = 1:(block_size-overlap)*cell_size:imsize(1)-overlap*cell_size
    for jb = 1:(block_size-overlap)*cell_size:imsize(2)-overlap*cell_size
        % Filter with Gaussian
        Gi_window = Gi(ib:ib+block_size*cell_size-1,...
            jb:jb+block_size*cell_size-1);
        Gtheta_window = Gtheta(ib:ib+block_size*cell_size-1,...
            jb:jb+block_size*cell_size-1);
%         Gi_window = imfilter(h,Gi_window,'replicate');
%         Gtheta_window = imfilter(h,Gtheta_window,'replicate');
        
        for ic = 0:cell_size:block_size*cell_size-1
            for jc = 0:cell_size:block_size*cell_size-1
                intensity = Gi_window(1+ic:ic+cell_size,...
                    1+jc:jc+cell_size);
                direction = Gtheta_window(1+ic:ic+cell_size,...
                     1+jc:jc+cell_size);
                votes = HOG_Vote(intensity,direction,bins); % bin the gradiants
                features(i:i+channels-1) = votes;
                i=i+channels;

                votes = 4*votes/(norm(votes,2)+.00001);
                figure(1);
                quiver(jb+jc+cell_size/2 * ones(1,channels*2),...
                    ib+ic+cell_size/2 * ones(1,channels*2),...
                    [votes votes].*[-cos(bins) -cos(bins+pi)],...
                    [votes votes].*[sin(bins) sin(bins+pi)],...
                    '.k','LineWidth',1);
            end
        end
        v = features(i-channels*block_size^2:i-1);
        v = v/(norm(v,2)+.00001);
        features(i-channels*block_size^2:i-1) = v;
    end
end
toc
axis ij
axis([1 256 1 256])