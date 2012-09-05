class Slider {

  String prefix;
  float x, y, w, h;
  boolean pressed;
  float value;
  int channel, minVal, maxVal;

  Slider(String _prefix, float _x, float _y, float _w, float _h, int _channel, int _minVal, int _maxVal ) {
    prefix=_prefix;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    channel = _channel;
    minVal = _minVal;
    maxVal = _maxVal;
  }

  void run() {
    // check for touch
    //if (checkBounds(x, y, w, h)) pressed = false;
    if (!mousePressed) pressed= false;

    // Send OSC
    if (pressed) {
      value = constrain(norm(mouseX, x, w), 0, 1);
      
      bundle(channel, int(map(value, 0,1, minVal, maxVal)));
      oscP5.send(myBundle, myRemoteLocation);
      myBundle.clear();
    }

    // background
    fill(60);
    noStroke();
    rect(x, y, w, h);

    // changing value
    fill(40);
    rect(x, y, value*w, h);

    // static outline
    noFill();
    strokeWeight(1);
    stroke(100);
    rect(x, y, w, h);
  }

  void checkHit() {
    if (checkBounds(x, y, w, h)) pressed = true;
  }
}

