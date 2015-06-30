// Jeffrey N. Murphy
// @MurphysLab
// 2015-06-30

// This presumes that the images in Folder A and in Folder B are in the same order!

// Get a list of images in Folder A
image_directory_A = getDirectory("Choose Folder A");
file_list_A = getFileList(image_directory_A);
image_list_A = newArray(0);
image_count_A = 0;
for(i=0; i<file_list_A.length; i++){
	if(endsWith(toLowerCase(file_list_A[i]),"tif")||endsWith(toLowerCase(file_list_A[i]),"png")){
		image_count_A++;
		image_list_A = Array.concat(image_list_A,file_list_A[i]);
	}
}

// Get a list of images in Folder B
image_directory_B = getDirectory("Choose Folder B");
file_list_B = getFileList(image_directory_B);
image_list_B = newArray(0);
image_count_B = 0;
for(i=0; i<file_list_B.length; i++){
	if(endsWith(toLowerCase(file_list_B[i]),"tif")||endsWith(toLowerCase(file_list_B[i]),"png")){
		image_count_B++;
		image_list_B = Array.concat(image_list_B,file_list_B[i]);
	}
}

if(image_count_B == image_count_A){
	for(img_i=0; img_i<image_count_A; img_i++){
		open(image_directory_A + image_list_A[img_i]);
		image_A = getImageID();
		open(image_directory_B + image_list_B[img_i]);
		image_B = getImageID();
		
		// IMAGE A
		selectImage(image_A);
		// do what you need to make your ROI
		close();
		
		// IMAGE B
		selectImage(image_B);
		// measure what you need using the ROI
		close();
	}
}
		

