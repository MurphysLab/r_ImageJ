// Single Mask Autocrop

// Macro for cropping both photo and a corresponding mask

// Jeffrey N. Murphy, 2020-07-12


// Set Measurements

run("Set Measurements...", "area mean center bounding redirect=None decimal=3");

function filenameAddSuffix(filename, ext1, ext2, suffix) { 
	// Adds suffix to a filename
	// e.g. "blahblah.ext" -> blahblahsuffix.ext
	string = substring(filename, 0,lengthOf(filename)-(lengthOf(ext1)+1));
	new_filename = string + suffix + "." + ext2;
	return new_filename;
}

// Files


// Where photos are stored
photo_directory = getDirectory("Photo Directory");
photo_files = getFileList(photo_directory);

// Where masks are stored
mask_directory = getDirectory("Mask Directory");
mask_files = getFileList(mask_directory);

// Where output files are saved
c_photo_directory = getDirectory("Photo-Output Directory (Cropped)");
c_mask_directory = getDirectory("Mask-Output Directory (Cropped)");

for(i=0; i<photo_files.length; i++){
	print(photo_files[i]);

	// Photo
	open( photo_directory + photo_files[i] );
	photo_title = getTitle();
	photo_ID = getImageID();
	wait(500);

	// Mask
	mask_filename = filenameAddSuffix(photo_files[i], "jpg", "png", "_CR");
	open( mask_directory + mask_filename );
	mask_title = getTitle();
	mask_ID = getImageID();
	wait(500);

	// Analyze Mask Image
	
	selectImage(mask_ID);
	setThreshold(254, 255);
	run("Analyze Particles...", "  circularity=0.20-1.00 display include");
	setResult("Mask", nResults-1, mask_title);
	setResult("Photo", nResults-1, photo_title);

	// Get Rectangle
	px_buffer = 30;
	w = getWidth();
	h = getHeight();
	
	n_i = nResults - 1;
	bx = maxOf( getResult("BX", n_i) - px_buffer , 0 ); // left side
	by = maxOf( getResult("BY", n_i) - px_buffer , 0 ); // top side
	bw = minOf( getResult("Width", n_i) + 2*px_buffer , w ); // right side
	bh = minOf( getResult("Height", n_i) + 2*px_buffer , h ); // bottom side
	
	// Crop Mask
	selectImage(mask_ID);
	makeRectangle(bx, by, bw, bh);
	run("Crop");
	mask_new = filenameAddSuffix(mask_title, "png", "tif", "_cropped");
	saveAs("Tiff", c_mask_directory + mask_new);
	close();
	
	// Crop Photo
	selectImage(photo_ID);
	makeRectangle(bx, by, bw, bh);
	run("Crop");
	photo_new = filenameAddSuffix(photo_title, "jpg", "tif", "_cropped");
	saveAs("Tiff", c_photo_directory + photo_new);
	close();
	
	
}


print("done");

