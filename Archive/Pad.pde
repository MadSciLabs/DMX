class Pad {

  String prefix;
  float x, y, w, h;
  boolean pressed;

  Pad(String _prefix, float _x, float _y, float _w, float _h) {
    prefix=_prefix;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }

  void run() {
    // check if still touching pad
    if (!checkBounds(x, y, w, h) || !mousePressed) pressed = false;
    
    // send OSC if touching pad
    if (pressed) {
      OscMessage myMessage = new OscMessage("/xy");
      myMessage.add(norm(mouseX, 0, width));
      myMessage.add(norm(mouseY, 0, height/3));
      oscP5.send(myMessage, myRemoteLocation);
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
  
  void checkHit(){
   if(checkBounds(x, y, w, h)) pressed = true;
  }
}


