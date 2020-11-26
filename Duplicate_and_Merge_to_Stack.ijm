// Description of the problem:

//     Open a stack (image sequence) and a single image. 
//     Combine the two (in two channels) by using a stack made up of duplicates of the single image.


// User Inputs

file_stack ="...."; // e.g. "D:/..../stack_01.tif"
file_single_image = "...."; // e.g. "D:/..../image_01.tif"


// Functions
function leadingZeroes(integer,max_digits){
	zeroes = max_digits - 1 - floor( log(integer) / log(10) );
	prefix = "";
	for(d=0; d<zeroes; d++){
		prefix += "0";
	}
	return prefix + integer
}

// Single Image
open(file_single_image);
id_single = getImageID();
title_single = getTitle();

// Corresponding Stack
open(file_stack);
id_stack = getImageID();
title_stack = getTitle();
N = nSlices;

// Duplicate Single Image to Stack

setBatchMode(true);
for(n=0; n<N; n++){
	selectImage(id_single);
	title = "include" + leadingZeroes( (n+1) , 4);
	run("Duplicate...", "title="+title);
}

run("Images to Stack", "name=Multi title=include use");

id_multi = getImageID();
title_multi = getTitle();

setBatchMode("exit and display");

// Merge two stacks

run("Merge Channels...", "c2="+title_stack+" c6="+title_multi+" create");
