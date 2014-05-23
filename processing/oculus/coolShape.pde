class CoolShape {
  PApplet parent;
  float scale = .01;
  //tS is short for "this shape" 

  OBJModel tS, bS;

  float[] f1 = new float[4];

  CoolShape(PApplet _parent) {
    parent = _parent;
    
    tS = new OBJModel(parent, "hypercube1.obj", "relative", QUADS);
    bS = new OBJModel(parent, "hypercube1.obj", "relative", QUADS);
    tS.disableDebug();
    bS.disableDebug();
    tS.disableMaterial();
    bS.disableMaterial();
    tS.scale(scale);
    bS.scale(scale);
  }

  void setValues(float[] in) {
    for (int i = 0; i < f1.length; i++) {
      f1[i] = in[i]/30.f;
    }
    updateVertex();
  }

  void updateVertex() {
    
    for (int i = 0; i < tS.getVertexCount(); i++) {
      PVector vec = bS.getVertex(i);
      tS.setVertex(i, vec.x+f1[i%4], vec.y+f1[(i+11)%4], vec.z+f1[(i+15)%4]);
    }
    tS.translateToCenter();
    bS.translateToCenter();
  }
}

