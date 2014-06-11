import ddf.minim.AudioInput;
import ddf.minim.AudioPlayer;
import ddf.minim.Minim;

class Lissa {
  public int ZTYPE = 1;

  public int BUFFERSIZE = 256;
  public float SAMPLERATE = 44100;
  public int BITDEPTH = 16;

  public int inputMode = 0;

  Minim minim;
  AudioInput in;

  AudioPlayer player;
  boolean playing = false;

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
    player = minim.loadFile("elixir.mp3");
  }

  void update() {
    switch(inputMode) {
    case 0:
      //bufferm = in.mix.toArray();
      buffer[0] = in.left.toArray();
      buffer[1] = in.right.toArray();

      //bufferm1 = ease(bufferm1, bufferm, (in.mix.level()) / 6.f, .76f);
      buffer1[0] = ease(buffer1[0], buffer[0], (in.mix.level()) / 6.f, .76f);
      buffer1[1] = ease(buffer1[1], buffer[1], (in.mix.level()) / 6.f, .76f);
      break;
    case 1:
      //bufferm = player.mix.toArray();
      buffer[0] = player.left.toArray();
      buffer[1] = player.right.toArray();

      //bufferm1 = ease(bufferm1, bufferm, (in.mix.level()) / 6.f, .76f);
      buffer1[0] = ease(buffer1[0], buffer[0], (in.mix.level()) / 6.f, .76f);
      buffer1[1] = ease(buffer1[1], buffer[1], (in.mix.level()) / 6.f, .76f);
      break;
    }
  }

  void drawLissa() {
    shapeMode(CENTER);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    noFill();
    stroke(255);
    pushMatrix();
    beginShape();
    for (int i = 0; i < BUFFERSIZE; i++) {
      float d = buffer[0][i] - buffer[1][i];
      strokeWeight(1.f + abs(d) * 3.f);
      float x = buffer1[0][i] * scaleX;
      float y = buffer1[1][i] * scaleY;
      float z = (((float)i / BUFFERSIZE)-.5f + d / 10.f) *scaleZ;
      curveVertex(x, y, z);
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

  public void play() {
    if (!player.isPlaying()) {
      player.play();
      inputMode = 1;
    } else {
      player.pause();
      player.rewind();
      inputMode = 0;
    }
  }

  public int getWorldAlpha() {
    if (player.isPlaying())
      return 255 - (int)(player.mix.level() * 255);
    else return 255 - (int)(lissa.in.mix.level() * 255);
  }
}

