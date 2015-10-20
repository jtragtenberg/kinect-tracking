import controlP5.*;

ControlP5 cp5;

Range range1;

Range range2;

int col = color(255);

boolean toggle1 = true;
boolean toggle2 = true;
int menuHeight = 90;


int rectX =0, rectY=0, rectWidth=width, rectHeight=height-menuHeight;


void initCP5() {

  cp5 = new ControlP5(this);
  range1 = cp5.addRange("Controle MIDI 1 (x)")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
      .setPosition(50, height - 70)
        .setSize(100, 20)
          .setHandleSize(10)
            .setDecimalPrecision(0)
              .setRange(0, 127)
                .setRangeValues(0, 127)
                  // after the initialization we turn broadcast back on again
                  .setBroadcast(true)
                    .setColorForeground(color(255, 40))
                      .setColorBackground(color(255, 40)) 
                        .setColorActive(color(100)) 
                          ;
  range2 = cp5.addRange("Controle MIDI 2 (y)")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 

      .setPosition(50, height - 40)
        .setSize(100, 20)
          .setHandleSize(10)
            .setDecimalPrecision(0)
              .setRange(0, 127)
                .setRangeValues(0, 127)
                  // after the initialization we turn broadcast back on again
                  .setBroadcast(true)
                    .setColorForeground(color(255, 40))
                      .setColorBackground(color(255, 40))
                        .setColorActive(color(100))
                          ;

  noStroke();

  // create a toggle
  cp5.addToggle("toggle1")
    .setPosition(20, height - 70)
      .setSize(20, 20)
        .setCaptionLabel("")
          .setValue(true)
            .setColorBackground(color(255, 40))
              .setColorActive(color(100))
                ;
  cp5.addToggle("toggle2")
    .setPosition(20, height - 40)
      .setSize(20, 20)
        .setCaptionLabel("")
          .setValue(true)
            .setColorBackground(color(255, 40))
              .setColorActive(color(100))
                ;
}


//Define o desenho dos triangulos

void mousePressed() {
  if (mouseY < height - menuHeight) {
    rectX=mouseX;
    rectY=mouseY;
  }
}


void mouseDragged() {
  if (mouseY < height - menuHeight) {
    rectWidth=mouseX-rectX;
    rectHeight=mouseY-rectY;
    rect(rectX, rectY, rectWidth, rectHeight);
  }
}

void mouseClicked() {
  if (mouseY < height - menuHeight) {
    rectX =0;
    rectY=0; 
    rectWidth=width; 
    rectHeight=height-menuHeight;
  }
}

