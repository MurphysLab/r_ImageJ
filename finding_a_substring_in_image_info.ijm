// Jeffrey N. Murphy
// @MurphysLab
// 2015-07-14

// There probably exists a better way to check specific EXIF tags.
// This is a simple method using getImageInfo() to find one or more predetermined strings.

all_the_info = getImageInfo();
print(all_the_info); // Copy the line that you want to find in other images.

match_string_1 = "[Exif IFD0] Model:	Nexus 5"; // The exact line copied from the print-out of getImageInfo();
match_string_2= "[Exif IFD0] Model:	Nexus 4";
match_1 = 0;
match_2 = 0;

// Define the range for searching substrings:
start = 0;
end = lengthOf(all_the_info)-maxOf(lengthOf(match_string_1),lengthOf(match_string_2));

// This goes through the entire output to find any instances of the substring
for(i=start; i<end; i++){
if( match_string_1 == substring(all_the_info,i,i+lengthOf(match_string_1)) ){ match_1 = 1; }
if( match_string_2 == substring(all_the_info,i,i+lengthOf(match_string_2)) ){ match_2 = 1; }
}

// Print the output
print("match 1: " + match_1);
print("match 2: " + match_2);