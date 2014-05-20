import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import de.voidplus.leapmotion.*;

LeapMotion leap;
PeasyCam cam;

PVector hand_position = new PVector();

void setup() {
  size(800, 500, P3D);
  background(255);
  noStroke(); 
  fill(50);
  // ...

  leap = new LeapMotion(this);
  cam = new PeasyCam(this, 500);
}


void draw() {
  background(255);
  for (Hand hand : leap.getHands()) {
    hand_position   = hand.getPosition();
    PVector hand_direction   = hand.getDirection();
    println(hand.getDirection());
    noFill();
    stroke(0);
    beginShape();
    for (Finger finger : hand.getFingers()) {
      vertex(hand_position.x, hand_position.y, hand_position.z);
      PVector finger_pos = finger.getPosition();
      vertex(finger_pos.x, finger_pos.y, finger_pos.z);
    }
    endShape();
  }
  translate(hand_position.x, hand_position.y, hand_position.z);
  sphere(4);
}

