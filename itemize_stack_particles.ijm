// Jeffrey N. Murphy
// @MurphysLab
// 2015-07-29

// A macro to help track particles in a stack. Presumes items are growing & moving slowly.
// Particles are found by going from the end of the stack to the beginning.
// Each ROI in the n^th slice is used to check the centre of each particle in the (n-1)^th slice.
// If the centre of the particle is inside the ROI, it is considered the same particle.
// Then the "Item" label from the particle in the n^th slice is applied to the matching particle in the (n-i)^th slice.

// Note that this presumes that the centre of mass should actually be within ROI

// Below is an example which will auto-generate a stack with particles to run as a test

setForegroundColor(0,0,0);
newImage("Example", "8-bit white", 400, 400, 5);

for(i=0; i<nSlices; i++){
	setSlice(i+1);
	
	makeOval(191-5*i, 213+3*i, 30+2*i, 26+2*i);
	run("Fill", "slice");
	
	makeOval(45+2.5*i, 54-2*i, 15+2*i, 18+2*i);
	run("Fill", "slice");
	
	makeOval(272-7*i, 114+4.3*i, 50+10*i, 52+8.3*i);
	run("Fill", "slice");
	
	makeOval(55+9*i, 208+6*i, 50+9.4*i, 52+8.1*i);
	run("Fill", "slice");
	
	if(i>=1){
	makeOval(325, 325, 27+20*i, 30+20*i);
	run("Fill", "slice");
	}
	
	if(i>=1){
		makeOval(205-5*i, 302-1*i, 27+2*i, 30+2*i);
		run("Fill", "slice");
	}
	
	if(i<4){
		makeOval(169-2*i, 99-2*i, 27+4*i, 30+4*i);
		run("Fill", "slice");
	}
}
run("Select None");


// Set Measurements... ensure "Stack Position" and "Centre" are included
run("Set Measurements...", "area mean min center stack redirect=None decimal=4");

// Analyze
run("Analyze Particles...", "display clear record add in_situ stack");
run("Remove Overlay");

// Set "Item" column to -1

for(i=0; i<nResults; i++){
	setResult("Item",i,-1);
}

// Number of objects in each slice

slice_n_count = newArray(nSlices);
slice_n_starts = newArray(nSlices);
slice_n_ends = newArray(nSlices);

slice = -1;
index = -1;
for(i=0; i<nResults; i++){
	new_slice = getResult("Slice",i);
	if(new_slice!=slice){
		index++;
		slice_n_ends[index] = i;
		slice_n_starts[index] = i;
		slice = new_slice;
	} else {slice_n_ends[index] = i;}
}

for(i=0; i<nSlices; i++){
	slice_n_count[i] = slice_n_ends[i]-slice_n_starts[i]+1;
}
Array.print(slice_n_starts);
Array.print(slice_n_ends);
Array.print(slice_n_count);


// Items in the final slice
item = 0;
for(i=0; i<nResults; i++){
	if(getResult("Slice",i)==nSlices){
		item++;
		setResult("Item",i,item);
		x = getResult("XM",i);
		y = getResult("YM",i);
		c = 100+item; setForegroundColor(c,c,c); floodFill(x,y);
	}
}

// Find Matching Items using isPointInPath
for(i=nSlices-1; i>0; i--){
	
	for(j=slice_n_starts[i]; j<slice_n_ends[i]+1; j++){
		roiManager("select", j);
		getSelectionCoordinates(xpoints, ypoints);
		run("Select None");
		for(k=slice_n_starts[i-1]; k<slice_n_ends[i-1]+1; k++){
			x = getResult("XM",k);
			y = getResult("YM",k);
			setSlice(i);
			if(isPointInPath(x, y, xpoints, ypoints)){
				setResult("Item",k,getResult("Item",j));
				c = 100+getResult("Item",j); setForegroundColor(c,c,c); floodFill(x,y);
			}
		}
	}
	// Check for missed ones:
	for(k=slice_n_starts[i-1]; k<slice_n_ends[i-1]+1; k++){
		if(getResult("Item",k)==-1){
			item++;
			setResult("Item",k,item);
			x = getResult("XM",k);
			y = getResult("YM",k);
			c = 100+item; setForegroundColor(c,c,c); floodFill(x,y);
		}
	}
}


// Marking with overlays:

for(i=0; i<nResults; i++){
slice = getResult("Slice",i);
	setSlice(slice);
	ii = getResult("Item",i);
	x = getResult("XM",i);
	y = getResult("YM",i);
	setFont("Sanserif", 12);
	Overlay.drawString(ii, x, y, 0);
	Overlay.setPosition(slice)
}
Overlay.show();




// Functions

// IsPointInPath //{{{
/** 	Adapted from Python code for the "EVEN-ODD RULE"
	source: http://en.wikipedia.org/wiki/Even-odd_rule  **/


function isPointInPath(x, y, xpoly, ypoly){
	num = xpoly.length;
	i = 0;
	j = num - 1;
	c = false;
	for(i=0; i<num; i++){
		if( ((ypoly[i] > y) != (ypoly[j] > y)) & (x < (xpoly[j] - xpoly[i]) * (y - ypoly[i]) / (ypoly[j] - ypoly[i]) + xpoly[i]) ){
			if(c){ c = false; } else { c = true; }  // c = not c
		}
		j = i;
	}
	return c;
} //)))