import ddf.minim.AudioInput;
import ddf.minim.Minim;

class Lissa {

  public int BUFFERSIZE = 512;
  public float SAMPLERATE = 44100;
  public int BITDEPTH = 16;

  Minim minim;
  AudioInput in;

  float bufferm[] = new float[BUFFERSIZE];
  float bufferm1[] = new float[BUFFERSIZE];
  float buffer[][] = new float[2][BUFFERSIZE];
  float buffer1[][] = new float[2][BUFFERSIZE];

  float scaleX, scaleY, scaleZ;

  Lissa(PApplet applet, float _scaleX, float _scaleY, float _scaleZ) {
    scaleX = _scaleX;
    scaleY = _scaleY;
    scaleZ = _scaleZ;
    minim = new Minim(applet);
    in = minim.getLineIn(Minim.STEREO, BUFFERSIZE, SAMPLERATE, BITDEPTH);
  }

  void update() {
    bufferm = in.mix.toArray();
    buffer[0] = in.left.toArray();
    buffer[1] = in.right.toArray();

    bufferm1 = ease(bufferm1, bufferm, (in.mix.level()) / 6.f, .76f);
    buffer1[0] = ease(buffer1[0], buffer[0], (in.mix.level()) / 6.f, .76f);
    buffer1[1] = ease(buffer1[1], buffer[1], (in.mix.level()) / 6.f, .76f);
  }

  void drawLissa() {
    update();
    shapeMode(CENTER);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    noFill();
    stroke(255);

    pushMatrix();
    rotateZ(-PI / 4.f);
    rotateY(PI / 8.f);
    beginShape();
    for (int i = 0; i < BUFFERSIZE; i++) {
      strokeWeight(.5f + abs(buffer[1][i] - buffer[0][i]) * 6.f);
      curveVertex(buffer1[0][i] * scaleX, buffer1[1][i] * scaleY, bufferm1[i] * scaleZ);
    }
    endShape();
    popMatrix();
  }

  public float[] ease(float[] a, float[] b, float offset, float mult) {
    int size = a.length;
    float out[] = new float[size];
    for (int i = 0; i < size; i++) {
      float rb;
      if (i + 1 < BUFFERSIZE) {
        // the bigger the difference between the current value in the buffer
        // and the next one is, the higher rb is.
        rb = abs(b[i] - b[i + 1]);
      } else
        rb = abs(b[i] - b[i - 1]);
      rb *= mult;
      rb += offset;
      out[i] = a[i] + (b[i] - a[i]) * rb;
    }
    return out;
  }
}
