classdef SlidingWindow
   properties
      pixels
      xstart
      ystart
      scale
   end
   methods
       function w = SlidingWindow(pixels,xstart,ystart,scale)
         w.pixels = pixels;
         w.xstart = xstart;
         w.ystart = ystart;
         w.scale = scale;
       end
       function wout = Mean(w,num)
           p = zeros(size(w(1).pixels)); xa = 0; ya = 0; sc = 0;
           for i=1:length(w)
               xa = xa + (w(i).xstart-1)*w(i).scale+1;
               ya = ya + (w(i).ystart-1)*w(i).scale+1;
               sc = sc + w(i).scale;
           end
           xa = xa/num;
           ya = ya/num;
           sc = sc/num;
           xs = (xa-1)/sc + 1;
           ys = (ya-1)/sc + 1;
           wout = SlidingWindow(p,xs,ys,sc);
       end
   end
end