newImage("Test Image", "8-bit ramp", 500, 500, 1);
makeLine(238,377,333,311,247,187,358,124);


getSelectionCoordinates(xcs,ycs); //xcs = x coordinates

segment_lengths = newArray(xcs.length-1);
segment_angles = newArray(xcs.length-2);

for(i=1; i<xcs.length; i++){
	segment_lengths[i-1] = sqrt( pow(xcs[i]-xcs[i-1],2) + pow(ycs[i]-ycs[i-1],2) );
}

for(i=2; i<xcs.length; i++){
	segment_angles[i-2] = dot_product_angle(xcs[i]-xcs[i-1],ycs[i]-ycs[i-1],xcs[i-2]-xcs[i-1],ycs[i-2]-ycs[i-1]);
}

// Overlays
Overlay.clear; //Clear previous overlays
Overlay.addSelection("FF5500",3);

// Angles
setFont("SanSerif", 14)
setColor("cyan");
for(i=0; i<segment_angles.length; i++){
	Overlay.drawString(segment_angles[i], xcs[i+1], ycs[i+1], 0); Overlay.show;
}

// Lengths
setFont("SanSerif", 14)
setColor("green");
for(i=0; i<segment_lengths.length; i++){
	Overlay.drawString(segment_lengths[i], (xcs[i+1]+xcs[i])/2, (ycs[i+1]+ycs[i])/2, 0); Overlay.show;
}

// Print
print("\nLengths (px)")
for(i=0; i<segment_lengths.length; i++){
	print( (i+1) + ": " + segment_lengths[i]);
	
}
print("\nAngles (deg)");
for(i=0; i<segment_angles.length; i++){
	print( (i+1) + ": " + segment_angles[i]);
}

// Functions:

  // Normalized Dot Product: a.b/(|a||b|)
  function dot_product_angle(vecxa,vecya,vecxb,vecyb){
    A = sqrt(vecxa*vecxa+vecya*vecya);
    B = sqrt(vecxb*vecxb+vecyb*vecyb);
    DP = vecxa*vecxb+vecya*vecyb;
    angle = 180 / PI * acos( DP/(A*B) );
    return angle;
  }