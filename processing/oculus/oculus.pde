import SimpleOculusRift.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

SimpleOculusRift   oculusRiftDev;

float   animRot = 0;
float   animLin1 = 5;
boolean animDirFlag1 = true;
float   animLin2 = 2;
boolean animDirFlag2 = true;

float floorDist = 1.7;

boolean   fullScreen = false;
//boolean   fullScreen = true;

void setup()
{
  if (fullScreen)
    size(1920, 1200, OPENGL);
  else    
    size(1280, 800, OPENGL);
  
  leap = new LeapMotion(this);
  setupHands();
  
  oculusRiftDev = new SimpleOculusRift(this, SimpleOculusRift.RenderQuality_Middle); 
  oculusRiftDev.setBknColor(0,0,0);  // just not total black, to see the barrel distortion
  
  strokeWeight(1);
  smooth();
}

void draw()
{
  oculusRiftDev.draw();
} 

void onDrawScene(int eye) {  
  stroke(200, 200, 220);
  fill(100, 100, 220);

  drawGrid(new PVector(0, -floorDist, 0), 10, 10);
  
  runHands();

//  // sphere
//  pushMatrix();
//  translate(-3, -floorDist + animLin1 - .5, 0);
//  sphere(1);
//  popMatrix();
//  animLin1 += .005 * (animDirFlag1 ? -1:1);
//  if (animLin1 < 3)
//    animDirFlag1 = !animDirFlag1;
//  else if (animLin1 > 8)
//    animDirFlag1 = !animDirFlag1;
//
//  // rot box
//  fill(100, 20, 100);
//  pushMatrix();
//  translate(0, 0, -3);
//  rotateY(animRot);
//  animRot+=.008;
//  box(1);
//  popMatrix();
//
//  // shift box
//  fill(100, 20, 20);
//  pushMatrix();
//  translate(animLin2, -floorDist + .5, -1.5);
//  box(1);
//  popMatrix();

  animLin2 += .01 * (animDirFlag2 ? -1:1);
  if (animLin2 < -1.0)
    animDirFlag2 = !animDirFlag2;
  else if (animLin2 > 3)
    animDirFlag2 = !animDirFlag2;

  // static box
//  fill(100, 200, 20);
//  pushMatrix();
//  translate(0, -floorDist + 1, 3);
//  box(2);
//  popMatrix();
}

boolean sketchFullScreen() 
{
  return fullScreen;
}     

void keyPressed()
{
  println("reset head orientation");
  oculusRiftDev.resetOrientation();
}

void drawGrid(PVector center, float length, int repeat)
{
  pushMatrix();
  translate(center.x, center.y, center.z);
  float pos;

  for (int x=0; x < repeat+1;x++)
  {
    pos = -length *.5 + x * length / repeat;

    line(-length*.5, 0, pos, 
    length*.5, 0, pos);

    line(pos, 0, -length*.5, 
    pos, 0, length*.5);
  }
  popMatrix();
}

