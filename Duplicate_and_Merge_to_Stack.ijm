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
open("D:/Estrella/201105_HSV1/Raw/201105_HSV1_MOI5_03hpi_Nuc001.nd2");
id_single = getImageID();
title_single = getTitle();

// Corresponding Stack
open("D:/Estrella/201105_HSV1/Raw/201105_HSV1_MOI5_03hpi_GEM001.nd2");
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
