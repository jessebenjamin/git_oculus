
PVector hand_position = new PVector();
PVector newHandPos = new PVector();

PVector hand_rotation = new PVector();
PVector newHandRot = new PVector();

PVector palm_position = new PVector();
PVector newPalmPos = new PVector();

PVector newFingerPos = new PVector();

float[] fingerLength = new float[5];
float[] maxFingerLength = new float[5];
float[] relFingerLength = new float[5];

void runHands() {
  pushMatrix();
  translate(-0.2, 0, 1.7);
  for (Hand hand : leap.getHands()) {
    hand_position = hand.getPosition();
    hand_rotation = hand.getDynamics();
    palm_position = hand.getPalmPosition();

    newHandPos = new PVector(
    hand_position.x/((float)width)*.5, 
    hand_position.y/((float)height)*-.5, 
    hand_position.z /50.f * (-0.5) - 2.
      );

    newPalmPos = new PVector(
    palm_position.x/((float)width)*.5, 
    palm_position.y/((float)height)*-.5, 
    palm_position.z /50.f * (-0.5) - 1.8
      );

    newHandRot = new PVector(
    radians(hand_rotation.x), 
    radians(hand_rotation.y), 
    radians(hand_rotation.z)
      );

    // Draw the hand
    noFill();
    stroke(255);
    strokeJoin(ROUND);

    int i = 0;

    for (Finger finger : hand.getFingers()) {


      PVector finger_pos = finger.getPosition();

      newFingerPos = new PVector(
      finger_pos.x/ (float)width *.5, 
      finger_pos.y/ (float)width *-.5, 
      finger_pos.z/ 50.f * -.5 - 2.
        );

      fingerLength[i] = finger.getLength();

      if (maxFingerLength[i] < fingerLength[i]) {
        maxFingerLength[i] = fingerLength[i];
      }


      relFingerLength[i] = maxFingerLength[i] - fingerLength[i];


      beginShape(LINES);
      vertex(newFingerPos.x, newFingerPos.y, newFingerPos.z);
      vertex(newHandPos.x, newHandPos.y, newHandPos.z);
      endShape();
      i++;
    }

    beginShape(LINES);
    vertex(newPalmPos.x, newPalmPos.y, newPalmPos.z);
    vertex(newHandPos.x, newHandPos.y, newHandPos.z);
    endShape();

    println(newPalmPos + " Hand: " + newHandPos);

    pushMatrix();
    translate(newHandPos.x, newHandPos.y, newHandPos.z);
    sphereDetail(6);
    sphere(0.01);
    popMatrix();

    pushMatrix();
    translate(newPalmPos.x, newPalmPos.y, newPalmPos.z);
    sphereDetail(6);
    sphere(0.01);
    popMatrix();
  }


  popMatrix();

  aniTranslation = new PVector(
  newHandPos.x, 
  newHandPos.y, 
  newHandPos.z
    );
}

