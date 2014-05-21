import SimpleOculusRift.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

SimpleOculusRift oculusRiftDev;

float floorDist = 1.7;
PVector aniRotation = new PVector();

boolean fullScreen = false;

void setup() {
  if (fullScreen)
    size(1920, 1200, OPENGL);
  else    
    size(1280, 800, OPENGL);
  
  leap = new LeapMotion(this);
  setupHands();
  
  oculusRiftDev = new SimpleOculusRift(this, SimpleOculusRift.RenderQuality_Middle); 
  oculusRiftDev.setBknColor(0,0,0);
  
  strokeWeight(1);
  smooth();
}


//Pass draw to library for barrel distortion etc
void draw() {
  oculusRiftDev.draw();
} 

//Draw for each eye
void onDrawScene(int eye) {

  drawGrid(new PVector(0, -floorDist, 0), 10, 10);
  
  runHands();
  
  pushMatrix();  
  stroke(0);
  fill(255);
  translate(0, 2, -3);
  rotateX(aniRotation.y);
  rotateY(aniRotation.x);
  rotateZ(aniRotation.z);
  sphere(1);
  popMatrix();
}

boolean sketchFullScreen() {
  return fullScreen;
}     

void drawGrid(PVector center, float length, int repeat) {
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

