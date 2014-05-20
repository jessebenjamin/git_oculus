PVector normalHand[] = new PVector[2];

PVector normalFingers[] = new PVector[5];

PVector hand_position = new PVector();

void runHands() {

  pushMatrix();
  translate(-0.1, 0, 1.5);
  for (Hand hand : leap.getHands()) {
    hand_position   = hand.getPosition();
    PVector hand_direction   = hand.getDirection();
    //println(hand.getDirection());
    noFill();
    stroke(255);
    beginShape();
    for (Finger finger : hand.getFingers()) {
      vertex((hand_position.x/((float)width))*.5, (hand_position.y/((float)height))*-.5, (hand_position.z / 100.f) * (-0.5) - 2);
      PVector finger_pos = finger.getPosition();
      vertex(finger_pos.x/ (float)width *.5, finger_pos.y/(float)width *-.5, finger_pos.z/ 100.f * -.5 - 2.);
    }
    endShape();
  }
  translate((hand_position.x/((float)width))*.5, (hand_position.y/((float)height))*-.5, (hand_position.z / 100.f) * (-0.5) - 2);
  sphere(4);
  popMatrix();

  //  updateHand();
  //
  //  for (Hand hand : leap.getHands()) {
  //    noFill();
  //
  //    pushMatrix();
  //    translate(-0.1, 0, 1.5);
  //    stroke(255);
  //    strokeWeight(3);
  //    beginShape();
  //    int fingers = hand.countFingers();
  //    vertex(normalHand[0].x, normalHand[0].y, normalHand[0].z);
  //    for (int x = 0; x < fingers; x++) {
  //      vertex(normalFingers[x].x, normalFingers[x].y, normalFingers[x].z);
  //    }
  //    endShape();
  //    popMatrix();
  //  }
}

void updateHand() {

  int handCount = leap.countHands();
  ArrayList<Hand> hands = leap.getHands();
  //println(hands.size());

  //    for (int i = 0; i < handCount; i ++) {
  if (handCount > 0) {
    //println(hands);
    Hand hand = hands.get(0);
    //println(hand + " " + hands);

    PVector hand_position = hand.getPosition();

    normalHand[0].x = (hand_position.x / ((float)width)) * (0.5) ;
    normalHand[0].y = (hand_position.y / ((float)height)) * (-0.5);
    normalHand[0].z = (hand_position.z / 100.f) * (-0.5) - 2;

    //println(normalHand[0]);


    for (Finger finger : hand.getFingers()) {
      PVector finger_pos = finger.getPosition();
      int fingers = hand.countFingers();
      for (int x = 0; x < fingers; x++) {
        normalFingers[x].x = finger_pos.x * (.5);
        normalFingers[x].y = finger_pos.y * (-.5);
        normalFingers[x].z = finger_pos.z / 100. * (.5);
      }
    }
    if (frameCount % 60 == 2) {
      println(normalFingers);
    }
  } 
  else {
    println("No hand.");
  }
}

void setupHands() {

  normalHand[0] = new PVector();
  normalHand[1] = new PVector();

  for (int i = 0; i< normalFingers.length; i++) {
    normalFingers[i] = new PVector();
  }
}

