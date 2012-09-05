class Button {
  String prefix;
  int id;
  float x, y, w, h;
  color[] c;
  PImage img = null;
  boolean pressed;

  Button(String _prefix, int _id, float _x, float _y, float _w, float _h, color[] _c, boolean useImg ) {
    prefix=_prefix;
    id=_id;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    c=_c;
    if (useImg) img = loadImage(prefix + "_" + id + ".png");
  }

  void checkHit() {
    if (checkBounds(x, y, w, h)) {
      OscMessage myMessage = new OscMessage("/" + prefix);
      myMessage.add(id); 
      oscP5.send(myMessage, myRemoteLocation);
      pressed = true;
    }
  }

  void run() {
    if (!mousePressed) pressed = false;

    noStroke();
    fill(c[0]);
    rect(x, y, w, h);

    //
    if (c.length >1) {
      fill(c[1]);
      rect(x+w/2, y, w/2, h);
    }
    if (img != null) image(img, x, y, w, h);

    // hit overlay
    if (pressed) fill(0, 100);
    else fill(255, 0);
    rect(x, y, w, h);

    //outline stroke
    strokeWeight(3);
    stroke(20);
    rect(x, y, w, h);
  }
}

