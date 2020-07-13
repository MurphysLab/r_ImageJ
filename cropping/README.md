# ImageJ Macros Related to Image Cropping


### mask_autocrop_macro.ijm

Designed to take photo & mask image pairs. Use the mask as a reference to crop the image. Created in response to [a thread on the ImageJ subreddit](https://www.reddit.com/r/ImageJ/comments/hpffhn/automate_image_processing_for_research_project/). Please include attribution if you re-use or adapt the code. 

Example to show what kind of images the code uses and what the output is:

| x        | Photo | Mask |
|----------|-------|------|
| Original | <img src="https://github.com/MurphysLab/r_ImageJ/blob/master/cropping/images/photo_example.jpg?raw=true" width="200">    | <img src="https://github.com/MurphysLab/r_ImageJ/blob/master/cropping/images/photo_example_CR.png?raw=true" width="200">     |
| Cropped  | <img src="https://github.com/MurphysLab/r_ImageJ/blob/master/cropping/images/photo_example_cropped.jpg?raw=true" width="200">    | <img src="https://github.com/MurphysLab/r_ImageJ/blob/master/cropping/images/photo_example_CR_cropped.png?raw=true" width="200">   |

The code as uploaded presumes that the mask filenames are identical to those of the corresponding photos, with the exception of a suffix, which is currently "\_CR", per the user question and the sample images.

The images should be sorted into 3-4 directories. Input images need to be in separate directories (unless you want to edit the macro to sort that out). *e.g.*

![directory structure](https://github.com/MurphysLab/r_ImageJ/blob/master/cropping/images/directory_structure.png?raw=true)

