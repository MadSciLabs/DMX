import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Button btns[] = new Button[24];
Slider sliders[] = new Slider[3];
Pad pads[] = new Pad[1];

PFont font;
int padding = 5;

OscMessage myMessage;
OscBundle myBundle;

void setup() {
  size(800, 1232);
  //800x1232
  print("Screen size: " + width + "x" + height);
  smooth();
  orientation(PORTRAIT);

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("10.80.2.200", 12000);
  //myRemoteLocation = new NetAddress("localhost", 12000);

  myMessage = new OscMessage("/cmd");
  myBundle = new OscBundle();

  font = createFont("SansSerif-Bold", 24);
  textFont(font);

  // Pads (set, x, y,w,h)
  pads[0] = new Pad("xy", 0, height-450, width, 430, 540, 270 );

  // Buttons (set, id, x, y,w,h, color, photo)
  for (int i=0; i<20; i++) {
    btns[i] = new Button("color", i, (i%10)*width/10, floor(i/10)*width/10+100, width/10, width/10, colors[i], false, btnChannel[i], btnVal[i]);
  }
  for (int i=20; i<btns.length; i++) {
    btns[i] = new Button("function", i, (i%10)*width/10, floor(i/10)*width/10+100, width/10, width/10, colors[20], true, btnChannel[i], btnVal[i]);
  }
  // Sliders (set, x, y,w,h)
  sliders[0] = new Slider("strobe", 0, 470, width, 50, 7, 8, 215);
  sliders[1] = new Slider("speed", 0, 570, width, 50, 5, 0, 255);
  sliders[2] = new Slider("intensity", 0, 670, width, 50, 8, 0, 255);
}


void draw() {
  background(20);

  // draw buttons
  for (int i=0; i<btns.length; i++) btns[i].run();

  // draw sliders
  for (int i=0; i<sliders.length; i++) sliders[i].run();

  // draw pads
  for (int i=0; i<pads.length; i++) pads[i].run();

  // draw text
  fill(200);
  rect(0, 0, width, 40);
  fill(20);
  text("DMX CONTROLLER", padding, 30);

  fill(255);
  text("LIGHT COLOR", padding, 90);
  text("STROBE SPEED", padding, 460);
  text("MOVEMENT SPEED", padding, 560);
  text("LIGHT INTENSITY", padding, 660);
  text("LIGHT POSITION", padding, 770);

  if (!mousePressed) noLoop();
}

void mousePressed() {
  loop();
  for (int i=0; i<btns.length; i++) btns[i].checkHit();
  for (int i=0; i<sliders.length; i++) sliders[i].checkHit();
  for (int i=0; i<pads.length; i++) pads[i].checkHit();
}

boolean checkBounds(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) return true;
  else return false;
}

void bundle(int channel, int value) {
  myMessage.setAddrPattern("/cmd");
  myMessage.add(channel);
  myMessage.add(value);
  myBundle.add(myMessage);
  myMessage.clear();
}
