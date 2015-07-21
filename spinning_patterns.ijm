// Spinning Patterns

// Number of black bars:
number = 30;

newImage("Hypnotism", "8-bit black", 400, 400, 60);

width = getWidth(); 
height = getHeight();

for(z=1; z<=nSlices; z++){
	Move from one slice to the next:
	setSlice(z);
	
	// Loop through x & y coordinates:
	for(y=0; y<height; y++){
		for(x=0; x<width; x++){
			// Determine the angle with respect to centre:
			theta = atan2( (y-height/2) , (x-width/2) );
			
			// Determine the value:
			value = 128*sin(number*theta + 2*PI*z/nSlices)+128;
			
			// Change the value of the pixel:
			setPixel(x,y,value);
		} //x-close
	} //y-close

} //z-close

// Set the animation speed:
run("Animation Options...", "speed=120 first=1 last=60");
// Start the animation:
doCommand("Start Animation [\\]");