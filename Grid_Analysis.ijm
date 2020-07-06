
//run("Set Measurements...", "area mean standard modal min bounding median redirect=None decimal=3");
run("Clear Results"); // empties the results table
// Grid Analysis Macro
// Created by Jeffrey N. Murphy (@MurphysLab)
// 2020-07-06

Overlay.clear; // clears any previous overlay data

img_input = getImageID();

w = getWidth();
h = getHeight();

box_width = 8;
box_height = 8;

number_x = round(w/box_width);
number_y = round(h/box_height);

output_data = newArray(number_x*number_y);
table_columns = newArray("k","i","j","xo","yo","area","mean","min","max","std","med"); // name columns in advance
table_row = newArray(table_columns.length); // this is unnecessary; just a reminder.

k = 0;
for(i=0; i<number_x; i++){
	for(j=0; j<number_y; j++){
		xo = i*box_width;
		yo = j*box_height;

		// Measure Data
		selectImage(img_input);
		makeRectangle(xo, yo, box_width, box_height);
		getStatistics(area, mean, min, max, std, histogram);
		med = getValue("Median"); // could do this from histogram
		table_row = newArray(k, i, j, xo, yo, area, mean, min, max, std, med);
		for(col=0; col<table_row.length; col++){
			setResult(table_columns[col], k, table_row[col]);
		}
		output_data[k] = mean;
		k++;

		Overlay.addSelection("30FFFF00", 1); // draws the overlay boxes.
		//print(i, j, area, mean, min, max, std); // no need to print - data is in the Results Table.
		//wait(125); // slow the process down to watch.
		
	}
}
updateResults();

newImage("Mean Map", "8-bit black", w, h, 1);
img_output = getImageID();

k = 0;
for(i=0; i<number_x; i++){
	for(j=0; j<number_y; j++){
		xo = i*box_width;
		yo = j*box_height;
		makeRectangle(xo, yo, box_width, box_height);
		v = output_data[k];
		k++;
		setForegroundColor(v, v, v);
		run("Fill", "slice");
	}
}