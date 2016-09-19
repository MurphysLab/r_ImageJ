directory = getDirectory("Where to save csv files?");

w = getWidth;
h = getHeight;
for(n=0; n<nSlices; n++){
	setSlice(n+1);
	for(x=0; x<w; x++){
		for(y=0; y<h; y++){
			value = getPixel(x,y);
			setResult(x,y,value);
		}
	}
	updateResults;
	saveAs("Results", directory+n+".csv");
}
