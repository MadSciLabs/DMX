import dmxP512.*;
import processing.serial.*;
import oscP5.*;
import netP5.*;

DmxP512 dmxOutput;
OscP5 oscP5;

String DMXPRO_PORT  =  "/dev/tty.usbserial-EN096254";
int DMXPRO_BAUDRATE =  115000;

void setup() { 
  size(255,255);

  dmxOutput=new DmxP512(this);
  dmxOutput.setupDmxPro(DMXPRO_PORT, DMXPRO_BAUDRATE);

  oscP5 = new OscP5(this, 12000);
  oscP5.plug(this, "cmd", "/cmd");
}

void draw() {
}

void mousePressed(){
    cmd(1, mouseX);

  
}

void cmd(int channel, int value) {
  println("channel: " + channel + "\tvalue: " + value); 
  dmxOutput.set(channel, value);
}

