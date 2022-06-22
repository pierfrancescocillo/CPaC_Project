# Interactive Theremin controlling a Game of Life
 
As a project for the Creative Computing and Programming course we developed a Theremin, based on color tracking, and the Game of life, whose patterns are controlled by the frequency and volume parameters of the Theremin.

## Setup and Design
In our application the screen is splitted in two: the left side recives inputs from the user camera while the right side implements the Game of Life.
The color tracking and the Game of Life algorithms are implemented in Processing, while we take advantage of Supercollider to convert the inputs percived from the user camera in sound.

## Color Tracking
First af all, the user must choose two physical, different-colored object that will control the Theremin.

That's because the determination of the frequency and the volume of the Theremin are implemented using the color tracking method. We suggest to use two pens with different-colored tips.

Before running the application the user must change the frequency and volume parameters (defined in our program as //) in order to, more or less, matched the colors of the two physical objects that he wants to use. The two colors must be different from one another in order to properly control the Theremin. 
The user can also decide a threashold for the two colors, in order to properly adjust the tracking done by the algorithm.

For both of the colors, the algorithm will scan every pixel of the camera and determine if a particulary pixel has the same color of the // or // parameter.

This tecnique is then improved by using the blob detection method: the algorithm not only determined if a pixel's color is close to the one assigned to the Volume or Frequency parameter, but also determine if the pixel belong to a specific region of close pixels of the same color. 

That's the use of the arrays of objects // and //: every element of these arrays is an object called region, and every region is composed by an array of coordinates of pixels (rapresented by PVectors).

Every time a new pixel of a particular color is tracked, the algorithm takes the array of objects for that specific color, takes the first region of this array and compute the distance between every pixel of this region and the current tracked pixel. If, for at least one pixel belonging to the region, this distance is less then a certain threashold, called //, then the pixel belong to that region. Otherwise we take the following region in the array of objects and repeat the procedure. If no region is found for a specific pixel (that means that the pixel is not enough close to any region in order to assign it to that region), a new region is created. This is implemented because, to evaluate the Volume and Frequency parameters, only regions with a certain amount of pixels will be taken into account, in order to avoid the tracking of small-background region whose pixels color match a tracked color. But due to the fact that this only works for regions with less than 500 pixels in our algorithm, is still preferable to chose neutral background while playing.


## Frequency and Volume Mapping
In our application the frequency of the instruement changes if we get close or far to the camera with the frequency- controlling physical object, while the volume changes depending on the vertical position of the Volume-controlling physical object.

The specific parameter that controls the frequency is the number of pixels beloning to the region (because more pixels means we are closer to the camera and viceversa), while the parameter that controls the Volume is the vertical (y position) of the center of the region (at the y=0 position of the canvas we will have no sound).

Both of this parameters are mapped in a specific Volume or Frequency, and sent using a OSC message to Supercollider.
In particular, the frequency is mapped in a value between 130.81 (Frequency of a C3) and 1046.5 (Frequency of a C6), allowing the theremin to cover three octaves, while the Volume is mapped in 0-1.

## Game of life
The classical Game of Life is a 2D grid cellular automata, in which each cell is "alive" or "dead" depending on the state of it's neighbors.

Being a 2D gird, each cell has 8 neighbors that can be dead or alive, as itself, so there are 512 possible neighbourhoods situations. Nevertheless, the situation becomes interesting when we base the behavior of each cell on the number of death and alive neighbors it has.

Typically, when a cell is alive, it can die in two ways:
* Overpopulation: if the cell has three or more neighbors
* Loneliness: if it has one or no neighbors

Instead, if it is dead, it can come to life if it has exactly three neighbors. In all the other cases, it will preserve it's current status.
This ruleset governing the Game of Life can be summarized with the following line of code:

```
  ruleset = {0,1,1,0,0,0,0,0,      0,0,1,0,0,0,0,0};
```
One of the first eight walues will be the next status of the cell if is alive (the first if it has one neighbor, the second if it has two, ecc...), and one of the other eight will apply if it is dead.

Starting from this point, we modified the ruleset as a function of the frequency. For each octave, the frequency is mapped in one of seven possible intervals, each one of them arbitrarily centered around one each note of the major diatonic scale in the key of C.

So we defined a set of seven different ruleset, starting from the classical one seen above, chosing which one applyes in the current time instant based according to the corresponding interval to which the current frequency played belongs. We have done this, ça va sans dire, so that the user is able to create and experience different graphic patterns, changing depending on the melody he or she is playing.

Furthermore
