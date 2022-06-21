# Interactive Theremin controlling a Game of Life
 
As a project for the Creative Computing and Programming course we develope a Theremin, based on color tracking, and the Game of life, whose patterns are controlled by the frequency and volume parameters of the Theremin.

## Setup and Design
In our application the screen is splitted in two: the left side recive input from the user camera while the right side implements the patterns generated in the Game of Life.
The color tracking and the Game of Life algorithms are implemented in Processing, while we take advantage of Supercollider to convert the inputs percived from the user camera in sound.

## Color Tracking
First af all, the user must choose two physical, different-colored object that will control the Theremin.
That's because the determination of the frequency and the volume of the Theremin are implemented using the color tracking method. We suggest to use two pens with different-colored tips.
Before running the application the user must change the frequency and volume colors parameters (defined in our program as VoltrackColor and FreqtrackColor) in order to, more or less, matched the colors of the two physical objects that he wants to use. The two colors must be different from one another in order to properly control the Theremin. 
The user can also decide a threashold for the two colors (thresholdVol and thresholdFreq variables), in order to properly adjust the tracking done by the algorithm.
For both of the colors, the algorithm will scan every pixel of the camera and determine if a particulary pixel has the same color of the VoltrackColor or FreqtrackColor parameter.
This tecnique is then improved by using the blob detection method: the algorithm not only determined if a pixel's color is close to the one assigned to the Volume or Frequency parameter, but also determine if the pixel belong to a specific region of close pixels of the same color. 
That's the use of the arrays of objects VolRegion and FreqRegion: every element of these arrays is an object called region, and every region is composed by an array of coordinates of pixels (rapresented by PVectors).
Every time a new pixel of a particular color is tracked, the algorithm takes the array of objects for that specific color, takes the first region of this array and compute the distance between every pixel of this region and the current tracked pixel. If, for at least one pixel belonging to the region, this distance is less then a certain threashold, called distThreshold, then the pixel belong to that region. Otherwise we take the following region in the array of objects and repeat the procedure. If no region is found for a specific pixel (that means that the pixel is not enough close to any region in order to assign it to that region), a new region is created. This is implemented because, to evaluate the Volume and Frequency parameters, only regions with a certain amount of pixels will be taken into account, in order to avoid the tracking of small-background region whose pixels color match a tracked color. But due to the fact that this only works for regions with less than 500 pixels in our algorithm, is still preferable to chose neutral background while playing.


## Frequency and Volume Mapping
In our application the frequency of the instruement changes if we get close or far to the camera with the frequency- controlling physical object, while the volume changes depending on the vertical position of the Volume-controlling physical object.
The specific parameter that controls the frequency is the number of pixels beloning to the region (because more pixels means we are closer to the camera and viceversa), while the parameter that controls the Volume is the vertical (y position) of the center of the region (at the y=0 position of the canvas we will have no sound).
Both of this parameters are mapped in a specific Volume or Frequency, and sent using a OSC message to Supercollider.
In particular, the frequency is mapped in a value between 130.81 (Frequency of a C3) and 1046.5 (Frequency of a C6), while the Volume is mapped in 0-1.


