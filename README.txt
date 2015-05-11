OBJECT DETECTION: TEAM DSP
 - Jeff Adolf (4243326) 
 - Vishal Vijayakumar(4874112)

*******************FILES IN DROPBOX***********************
All supplemental files and models necessary to run the object detection code are in the dropbox link: 

https://www.dropbox.com/sh/ftxu290k5p7urip/AACXhFPIjE5W1agl4N6bMN5Pa?dl=0

STORE THE FILES IN ABOVE LINK IN A DIRECTORY LABELLED ‘Pedestrian-Detection/Files'

THE PRESENTATION, REPORT, AND OUTPUT VIDEOS ARE ALSO INCLUDED IN THE FILES DIRECTORY.


*******************FILES IN GITHUB***********************
The code files are in the GitHub repository. Link provided below:

https://github.com/jpadolf/Pedestrian-Detection-Code

This link has all the MATLAB files needed to run the data.

STORE THE MATLAB FILES IN ABOVE LINK IN A DIRECTORY LABELLED 'Pedestrian-Detection/Code'


*******************RUNNING THE CODE***********************

1) Run the function startup.m while the current MATLAB directory is set to the 'Code' folder.
The parent folder of 'Code' should also contain the 'Files' folder downloaded from DropBox.

2) The function 'detect_pedestrian' runs the main algorithm to detect a pedestrian in the image.

   detect_pedestrian(image_path,model_name,number_scales,overlap_pixels,scaling_factor,toSRS)
	a) image_path gives the relative or absolute string location of the input image
	b) model_name is the name of the classifier model: mod2 if loaded from startup.m
	c) number_scales looks at the top 'n' scales. a value of 0 implies parsing all scales.
	d) overlap_pixels is the number of pixels between the current and the next window.
	e) scaling_factor indicates the amount of scaling done to the image. Best value is 0.8.
	f) toSRS is the option of computing the Single Response Suppression of each input image.

3) The function 'makevideo' takes input video frames, detects the object in each
frame, and collects all the output frames into one video, which is then saved.
By default, it uses number_scales = 0, overlap_pixels=10, scaling_factor=.8, and toSRS=1.

    makevideo(inputDir, outputDir, model)
	a) inputDir is the path that contains the input video frames.
	b) outputDir is the path that the final output video is written into.
	c) model is the name of the classifier model: mod2 if loaded from startup.m

***********************EXAMPLES****************************************

1) EXAMPLE FOR PEDESTRIAN DETECTION:
	detect_pedestrian('../Files/test/pos/crop_000012.png',mod2,2,16,0.75,0);
	detect_pedestrian('../Files/test/pos/crop_000016.png',mod2,3,16,0.75,1);
	detect_pedestrian('../Files/TestVideo1/20m_11s_944354u.pgm’,mod2,0,10,0.8,1);

2) EXAMPLE FOR MAKING A VIDEO:
	inputdir = '../Files/TestVideo2';
	outputdir = '../Files/Outputvideo2';
	makevideo(inputdir,outputdir,mod2);