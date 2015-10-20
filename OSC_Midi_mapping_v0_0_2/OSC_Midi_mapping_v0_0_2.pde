import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

static int CONTROLE_MIDI_X = 1;
static int CONTROLE_MIDI_Y = 2;
static int TAMANHO_CIRCULO = 30;


//define as variaveis globais:

float[] PosX = new float[10];
float[] PosY = new float[10];
int[] Cor = new int[10];

int[] valueAnterior = new int[127];

int[] ValorMidiMin = new int[127];
int[] ValorMidiMax = new int[127];
float[] ValorOscMin = new float[127];
float[] ValorOscMax = new float[127];


void setup() {
  size(800, 690);//o menu de baixo tem 90 de altura
  frameRate(30);
  colorMode(HSB, 255);
  
  //inicializacao do MIDI
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 3, 4); 
  
  //inicializacao do OSC
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 3333);
  myRemoteLocation = new NetAddress("127.0.0.1", 3333);
  oscP5.plug(this, "readKinect", "/tuio/2Dcur");

  //Inicializacao dos objetos visuais CP5
  initCP5();

  //inicializacao do valores iniciais de configuracao
  for (int i=0; i<127; i++) {
    ValorMidiMin[i] = 0;
    ValorMidiMax[i] = 127;
    ValorOscMin[i] = 0;
    ValorOscMax[i] = 1;
  }
  rectX =0;
  rectY=0; 
  rectWidth=width-1; 
  rectHeight=height-menuHeight;
}




void draw() {
  background(0);
  fill(120);
  stroke(120);
  rect(0, height - menuHeight, width, menuHeight);
  Cor[0] = IdsAtivas[0]%255;
  PosX[0] = map(X[0], 0, 1, 0, width);
  PosY[0] = map(Y[0], 0, 1, 0, height-menuHeight);


  desenhaAtor(PosX[0],PosY[0],Cor[0]); //desenha o primeiro ator (blob) rastreado
  desenhaRetangulo(); //desenha o retangulo que interessa
  configRetangulo(); //mapeia os valores do retangulo desenhado 
  
  
  //verifica se o valor rastreado esta dentro do retangulo
  if ((X[0] > ValorOscMin[CONTROLE_MIDI_X] && X[0] < ValorOscMax[CONTROLE_MIDI_X]) && (Y[0] > ValorOscMin[CONTROLE_MIDI_Y] && Y[0] < ValorOscMax[CONTROLE_MIDI_Y]) ) {
    if (toggle1) { //se o controle Midi X estiver habilitado
      mandaMidi(X[0], CONTROLE_MIDI_X); //mapeia o valor da componente X da posicao em parametros midi e manda como controle de numero 1
    }
    if (toggle2) { //se o controle Midi Y estiver habilitado
      mandaMidi(Y[0], CONTROLE_MIDI_Y); //mapeia o valor da componente Y da posicao em parametros midi e manda como controle de numero 2
    }
  }
  /*
  if (qtdeAtores >= 2) {
   Cor[1] = IdsAtivas[1]%255;
   PosX[1] = map(X[1], 0, 1, 0, 400);
   PosY[1] = map(Y[1], 0, 1, 0, 400);
   
   desenhaAtor(1);
   }
   */
}

void desenhaAtor(float posX, float posY, float cor) {
  stroke(cor, cor, 255);
  fill(cor,cor, 255);
  ellipse(posX, posY, TAMANHO_CIRCULO, TAMANHO_CIRCULO);
}

void desenhaRetangulo() {
  noFill();
  rect(rectX, rectY, rectWidth, rectHeight);
}

void configRetangulo(){
  if (rectWidth > 0) {
    ValorOscMin[CONTROLE_MIDI_X] = map(rectX, 0, width, 0, 1);
    ValorOscMax[CONTROLE_MIDI_X] = map(rectX+rectWidth, 0, width, 0, 1);
  } else {
    ValorOscMax[CONTROLE_MIDI_X] = map(rectX, 0, width, 0, 1);
    ValorOscMin[CONTROLE_MIDI_X] = map(rectX+rectWidth, 0, width, 0, 1);
  }
  if (rectHeight > 0) {
    ValorOscMin[CONTROLE_MIDI_Y] = map(rectY, 0, height-menuHeight, 0, 1);
    ValorOscMax[CONTROLE_MIDI_Y] = map(rectY+rectHeight, 0, height-menuHeight, 0, 1);
  } else {
    ValorOscMax[CONTROLE_MIDI_Y] = map(rectY, 0, height-menuHeight, 0, 1);
    ValorOscMin[CONTROLE_MIDI_Y] = map(rectY+rectHeight, 0, height-menuHeight, 0, 1);
  }  
}

void mandaMidi(float valueOSC, int n) {
  int channel = 0;
  if (valueOSC > ValorOscMin[n] && valueOSC < ValorOscMax[n]) {
    int value = (int)map(valueOSC, ValorOscMin[n], ValorOscMax[n], ValorMidiMin[n], ValorMidiMax[n]);
    if (value>ValorMidiMax[n]) value = ValorMidiMax[n];
    if (value<ValorMidiMin[n]) value = ValorMidiMin[n];
    if (valueAnterior[n] != value) {//so manda se o valor variar
      myBus.sendControllerChange(channel, n, value); // Send a controllerChange
    }
    valueAnterior[n] = value;
  }
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("Controle MIDI 1 (x)")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    ValorMidiMin[1] = int(theControlEvent.getController().getArrayValue(0));
    ValorMidiMax[21] = int(theControlEvent.getController().getArrayValue(1));
    println("range update, done.");
  }
  if (theControlEvent.isFrom("Controle MIDI 2 (y)")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    ValorMidiMin[2] = int(theControlEvent.getController().getArrayValue(0));
    ValorMidiMax[2] = int(theControlEvent.getController().getArrayValue(1));
    println("range update, done.");
  }
}

