
getSelectionCoordinates(xs,ys);

for(i=0; i<xs.length; i++){
	setResult("x",nResults,xs[i]);
	setResult("y",nResults-1,ys[i]);
}


Dialog.create("Overlays");
Dialog.addCheckbox("Add overlays of cell positions?", true);
Dialog.show();
overlay = Dialog.getCheckbox();

if(overlay){
	Overlay.addSelection("#8000FFFF");
	Overlay.show;
}

run("Select None");

waitForUser("Now Select the region and click OK");

getSelectionBounds(xo,yo,wo,ho);

count = 0;
for(i=0; i<nResults; i++){
	x = getResult("x",i);
	y = getResult("y",i);
	if(x >= xo && x <= xo + wo && y >= yo && y < yo + ho){
		count++;
	}
}

print("Count: " + count);

Dialog.create("Selections");
Dialog.addCheckbox("Show the cell selections again?", true);
Dialog.show();
select = Dialog.getCheckbox();

if(select){
	makeSelection("point",xs,ys);
}
