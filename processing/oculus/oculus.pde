/* --------------------------------------------------------------------------
 * OCULEAP   ----------------------------------------------------------------
 * --------------------------------------------------------------------------
 * VR 3D Vertex Manipulation using Oculus Rift DK1 and Leap Motion Controller
 * https://github.com/jessebenjamin/git_oculus
 * --------------------------------------------------------------------------
 * prog:  Jesse Benjamin & Alexander Morosow / Interaction Design / BTK-FH/ http://btk-fh.de/
 * date:  05/23/2014 (m/d/y)
 *
 * --------------------------------------------------------------------------
 * REQUIREMENTS:
 * --------------------------------------------------------------------------´
 *
 *  • Oculus Rift DevKit 1
 *  • Leap Motion Sensor & SDK
 *  • Processing-Libraries (see below)
 *
 * --------------------------------------------------------------------------
 * HOW TO USE:
 * --------------------------------------------------------------------------´
 *
 *  1. Hold and move one hand over the Leap-Sensor to manipulate an object in space.
 *  2. Use keys '1', '2' & '3' to alternate between objects.
 *  3. Use key 'r' to reset the variables for Object 3.
 *  4. Use key 'r' to reset the variables for Object 3.
 *  5. Place two hands over the Leap-Sensor to freeze the objects.
 *
 */

/* ----------------------------------------------------------------------------
 *
 * Processing library SimpleOculusRift Basic by Max Rheiner, 2014
 *
 * ----------------------------------------------------------------------------
 *
 * Processing library LeapMotionForProcessing by Darius Morawiec. (C) 2013
 *
 * ----------------------------------------------------------------------------
 *
 * Processing library OBJLoader by Saito, Matt Ditton, Ekene Ijeoma. (c) 2010
 *
 */

import SimpleOculusRift.*;
import de.voidplus.leapmotion.*;
import saito.objloader.*;


LeapMotion leap;

SimpleOculusRift oculusRiftDev;

CoolShape shape;

Lissa lissa;

float floorDist = 1.7;

PVector aniTranslation = new PVector();


int keyShape = 1;

int alpha = 255;

PImage noCurse;

void setup() {
  size(1280, 800, OPENGL);

  hint(DISABLE_DEPTH_TEST);
  
  oculusRiftDev = new SimpleOculusRift(this, SimpleOculusRift.RenderQuality_Middle);
  oculusRiftDev.setBknColor(0, 0, 0);

  leap = new LeapMotion(this);
  shape = new CoolShape(this);

  // Lissa(PApplet applet, float _scaleX, float _scaleY, float _scaleZ)
  lissa = new Lissa(this, 50, 50, 5);

  smooth();
  
  noCurse = loadImage("noCursor.png");
  cursor(noCurse);
}


//Pass draw to library for barrel distortion etc
void draw() {
  if (leap.countHands() == 1) {
    shape.setValues(relFingerLength);
  }

  lissa.update();

  oculusRiftDev.draw();
}

//Draw for each eye
void onDrawScene(int eye) {

  if (keyShape == 4) {
    strokeWeight(1+lissa.in.mix.level()*2.f);
    alpha = lissa.getWorldAlpha();
  } else {
    strokeWeight(1);
    alpha = 255;
  }

  drawGrid(new PVector(0, -floorDist, 0), 30, 30);
  stroke(255, alpha / 2);
  noFill();
  sphereDetail(24);
  sphere(100);
  if (leap.countHands() == 1)
    runHands();

  pushMatrix();
  translate(-2+(aniTranslation.x*8.), 6+aniTranslation.y*12., 25.+(aniTranslation.z*15.));
  rotateX(newHandRot.x);
  rotateY(newHandRot.y);
  rotateZ(newHandRot.z);
  noFill();
  stroke(color(255));
  switch(keyShape) {
  case 1:
    box(3);
    break;
  case 2:
    float sphereSize = 5.-constrain(abs(aniTranslation.y)*10., 1, 10);
    sphereDetail(6);
    sphere(sphereSize);
    break;
  case 3:
    shape.tS.draw();
    break;
  case 4:
    lissa.drawLissa();
    break;
  }

  popMatrix();
}

void drawGrid(PVector center, float length, int repeat) {
  pushMatrix();
  stroke(255, alpha);
  translate(center.x, center.y, center.z);
  float pos;

  for (int x=0; x < repeat+1; x++)
  {
    pos = -length *.5 + x * length / repeat;

    line(-length*.5, 0, pos, 
    length*.5, 0, pos);

    line(pos, 0, -length*.5, 
    pos, 0, length*.5);
  }
  popMatrix();
}

void keyReleased() {
  if (key == '1') {
    keyShape = 1;
  } else if (key == '2') {
    keyShape = 2;
  } else if (key == '3') {
    keyShape = 3;
  } else if (key == '4') {
    keyShape = 4;
  } else if (keyCode == ' ' && keyShape == 4) {
    lissa.play();
  }
  if (key == 'r' || key == 'R' || key == '3') {
    for (int i = 0; i < maxFingerLength.length; i++) {
      maxFingerLength[i] = 0;
    }
  }
  cursor(noCurse);
}


public void mouseMoved() {
  cursor(noCurse);
}

