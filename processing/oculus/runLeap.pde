public static float HANDSCALE = .5f;
public static float ABS_HANDPOS = 2.f;

void runHands() {

  pushMatrix();
  translate(-0.1, 0, 1.5);
  for (Hand hand : leap.getHands()) {
    
    // Get position from leap
    PVector hand_position = hand.getPosition();
    
    // Calculate position in Oculus' coordinate system
    PVector n_hand_pos = new PVector(
    hand_position.x / (float) width * HANDSCALE,
    hand_position.y / (float) height * -HANDSCALE,
    hand_position.z / 100.f * -HANDSCALE - ABS_HANDPOS);
    
    // Draw the hand
    noFill();
    stroke(255);
    beginShape();
    for (Finger finger : hand.getFingers()) {
      // Each finger consists of two vertices, one for the wrist, one for the finger
      vertex(n_hand_pos.x, n_hand_pos.y, n_hand_pos.z);
      PVector finger_pos = finger.getPosition();
      vertex(
      finger_pos.x / (float)width *HANDSCALE,
      finger_pos.y / (float)width *-HANDSCALE,
      finger_pos.z/ 100.f * -HANDSCALE - ABS_HANDPOS);
    }
    endShape();
  }
  // Finally we draw the wrist
  pushMatrix();
  translate(
  hand_position.x/(float)width*HANDSCALE,
  hand_position.y/(float)height*-HANDSCALE,
  hand_position.z / 100.f * -HANDSCALE - ABS_HANDPOS);
  sphere(4);
  popMatrix();
  popMatrix();

}

void setupHands() {
}

