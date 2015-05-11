function spatial_windows = slide_window(I,step,scale)

[ysize, xsize,~] = size(I);
rangei = [1:step:ysize-127 ysize-127];
if (rangei(end) == rangei(end-1)), rangei = rangei(1:end-1); end
rangej = [1:step:xsize-63 xsize-63];
if (rangej(end) == rangej(end-1)), rangej = rangej(1:end-1); end

initwindow = SlidingWindow(0,0,0,0);
spatial_windows = repmat(initwindow,length(rangei),length(rangej));

indexi=0;
for i = rangei
    indexj=0;
    indexi = indexi+1;
    for j = rangej
        indexj = indexj+1;
        w = I(i:i+127,j:j+63,:);
        %window = SlidingWindow(w,(j-1)*scale+1,(i-1)*scale+1,scale);
        window = SlidingWindow(w,j,i,scale);
        spatial_windows(indexi,indexj) = window;
    end
end