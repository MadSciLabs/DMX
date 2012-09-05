class Pad {

  String prefix;
  float x, y, w, h, panMax, tiltMax;
  boolean pressed;
  float fineMax  = 3.0;
  

  Pad(String _prefix, float _x, float _y, float _w, float _h, float _panMax, float _tiltMax) {
    prefix=_prefix;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    panMax = _panMax;
    tiltMax = _tiltMax;
  }

  void run() {
    // check if still touching pad
    if (!checkBounds(x, y, w, h) || !mousePressed) pressed = false;

    // send OSC if touching pad
    if (pressed) {
      setRotate(1, 1-norm(mouseX, x, x+w), panMax); 
      setRotate(2, 1-norm(mouseY, y, y+h), tiltMax); 

      oscP5.send(myBundle, myRemoteLocation);
      myBundle.clear();
    }

    // Draw XY pad
    fill(50);
    stroke(20);
    rect(x, y, w, h);

    // show touch
    if (pressed) {
      fill(255, 200);
      noStroke();
      ellipse(mouseX, mouseY, 30, 30);
    }
  }

  void checkHit() {
    if (checkBounds(x, y, w, h)) pressed = true;
  }

  void setRotate(int channel, float deg, float axisMax) {

    float val    = deg*255.0;
    int coarse   = floor(val);
    int fine     = round((val-coarse)*axisMax/fineMax);

   //  println("channel: " + channel + "\tDegree: " + deg + "\tCoarse: " + coarse + "\tFine: " + fine);
    bundle(channel, coarse);
    bundle(channel+2, fine);
    
    // dmxOutput.set(channel, coarse);
    // dmxOutput.set(channel+2, fine);
  }


}

