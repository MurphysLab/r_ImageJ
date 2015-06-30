// Jeffrey N. Murphy
// @MurphysLab
// 2015-06-30

// An imperfect means for marking angles on an image.

// Open an image and use the "Angle tool" to measure an angle
open("https://i.imgur.com/E6EIo.jpg");
makeSelection("angle",newArray(645,473,656),newArray(127,169,168));
run("Measure");

// Get the angle
angle = getResult("Angle",nResults-1); //obtains angle from the results table
angle_s = toString(angle,2); //rounds to 2 decimal places

// Set Line Width and Colour, then Draw
setLineWidth(2); // makes the line 5 pixels wide
setForegroundColor(255, 255, 0); //makes foreground colour yellow
run("Draw"); // draws the current selection

// This should mark the midpoint between the ends of the angle
getSelectionCoordinates(xpoints, ypoints);
x = (xpoints[0] + xpoints[2])/2;
y = (ypoints[0] + ypoints[2])/2;

// Write the angle between the end points
setFont("Monospaced",14,"bold");
setJustification("center");
drawString(angle_s,x,y);
