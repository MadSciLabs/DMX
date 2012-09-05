class Slider {

  String prefix;
  float x, y, w, h;
  boolean pressed;
  float value;

  Slider(String _prefix, float _x, float _y, float _w, float _h ) {
    prefix=_prefix;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }

  void run() {
    // check for touch
    //if (checkBounds(x, y, w, h)) pressed = false;
    if(!mousePressed) pressed= false;

    // Send OSC
    if (pressed) {
      value = constrain(norm(mouseX, x, w), 0, 1);
      OscMessage myMessage = new OscMessage("/" + prefix);
      myMessage.add(value); 
      oscP5.send(myMessage, myRemoteLocation);
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
    if(pressed) println("Test");
  }
}

