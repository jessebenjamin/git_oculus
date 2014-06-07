OCULEAP
==========
VR 3D Vertex Manipulation using Oculus Rift DK1 and Leap Motion Controller
https://github.com/jessebenjamin/git_oculus
--------------------------------------------------------------------------
prog:  Jesse Benjamin & Alexander Morosow / Interaction Design / BTK-FH/ http://btk-fh.de/
date:  05/23/2014 (m/d/y)

--------------------------------------------------------------------------
REQUIREMENTS:
--------------------------------------------------------------------------

- Oculus Rift DevKit 1
- Leap Motion Sensor & SDK
- Processing-Libraries (see below)
- Stereo audio input
  
--------------------------------------------------------------------------
HOW TO USE:
--------------------------------------------------------------------------

1. Hold and move one hand over the Leap-Sensor to manipulate an object in space.
2. Use keys '1', '2', '3' & '4' to alternate between objects.
3. Use key 'r' to reset the variables for Object 3.
4. Place two hands over the Leap-Sensor to freeze the objects.

The 4th mode is a music visualizer.
It works on the principle of Lissajous figures - drawing phase differences in the signal of the incoming audio.

For the 4th mode to work, you need to select a two channel audio input as the system input.

I suggest using Soundflower to route the system audio to the input.
Soundflowerbed lets you send the signal to an output as well.

Try pressing the spacebar when in mode 4. for a proposed track ;)

----------------------------------------------------------------------------

Processing library SimpleOculusRift Basic by Max Rheiner, 2014

----------------------------------------------------------------------------

Processing library LeapMotionForProcessing by Darius Morawiec. (C) 2013

----------------------------------------------------------------------------

Processing library OBJLoader by Saito, Matt Ditton, Ekene Ijeoma. (c) 2010
