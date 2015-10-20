/**
 * oscP5plug by andreas schlegel
 * example shows how to use the plug service with oscP5.
 * the concept of the plug service is, that you can
 * register methods in your sketch to which incoming 
 * osc messages will be forwareded automatically without 
 * having to parse them in the oscEvent method.
 * that a look at the example below to get an understanding
 * of how plug works.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;

int[] IdsAtivas = new int[10];
int qtdeAtores = 1;
float[] X = new float[10];
float[] Y = new float[10];


public void readKinect(String tipo, int id, float x, float y, float vx, float vy, float a) {  
  //println("--------------> mensagem com o Id"+id);
  println("id"+id+": ("+x+","+y+")");
  for(int i=0; i<10; i++){
    if (id == IdsAtivas[i]){
      X[i] = x;
      Y[i] = y;
    }
  }
}

public void readKinect(String tipo, int id0) {  
  if (tipo.equals("alive") == true) {
    println("1 id ativa:"+id0);
    IdsAtivas[0] = id0;
    qtdeAtores = 1;
    for (int i=1; i<10; i++) IdsAtivas[i] = 0;
  }
}

public void readKinect(String tipo, int id0, int id1) {  
  println("2 ids ativas:"+id0+","+id1);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  qtdeAtores = 2;
  for (int i=2; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2) {  
  println("3 ids ativas:"+id0+","+id1+","+id2);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  qtdeAtores = 3;
  for (int i=3; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2, int id3) {  
  println("4 ids ativas:"+id0+","+id1+","+id2+","+id3);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  qtdeAtores = 4;
  for (int i=4; i<10; i++) IdsAtivas[i] = 0;
}


public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4) {  
  println("5 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  qtdeAtores = 5;
  for (int i=5; i<10; i++) IdsAtivas[i] = 0;
}


public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4, int id5) {  
  println("6 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4+","+id5);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  IdsAtivas[5] = id5;
  qtdeAtores = 6;
  for (int i=6; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4, int id5, int id6) {  
  println("7 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4+","+id5+","+id6);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  IdsAtivas[5] = id5;
  IdsAtivas[6] = id6;
  qtdeAtores = 7;
  for (int i=7; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4, int id5, int id6, int id7) {  
  println("8 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4+","+id5+","+id6+","+id7);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  IdsAtivas[5] = id5;
  IdsAtivas[6] = id6;
  IdsAtivas[7] = id7;
  qtdeAtores = 8;
  for (int i=8; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4, int id5, int id6, int id7, int id8) {  
  println("9 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4+","+id5+","+id6+","+id7+","+id8);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  IdsAtivas[5] = id5;
  IdsAtivas[6] = id6;
  IdsAtivas[7] = id7;
  IdsAtivas[8] = id8;
  qtdeAtores = 9;
  for (int i=9; i<10; i++) IdsAtivas[i] = 0;
}

public void readKinect(String tipo, int id0, int id1, int id2, int id3, int id4, int id5, int id6, int id7, int id8, int id9) {  
  println("10 ids ativas:"+id0+","+id1+","+id2+","+id3+","+id4+","+id5+","+id6+","+id7+","+id8+","+id9);
  IdsAtivas[0] = id0;
  IdsAtivas[1] = id1;
  IdsAtivas[2] = id2;
  IdsAtivas[3] = id3;
  IdsAtivas[4] = id4;
  IdsAtivas[5] = id5;
  IdsAtivas[6] = id6;
  IdsAtivas[7] = id7;
  IdsAtivas[8] = id8;
  IdsAtivas[9] = id9;
  qtdeAtores = 10;
}


