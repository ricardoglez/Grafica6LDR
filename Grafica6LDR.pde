import processing.opengl.*;
import processing.serial.*;

Serial miPuerto;

int[] ldrValor = {
  0, 0, 0, 
  0, 0, 0, 
  0, 0, 0, 
  0, 0, 0
};

float inByte[] = {
  0, 0, 0, 
  0, 0, 0, 
  0, 0, 0, 
  0, 0, 0
};
boolean actividad[] = {
  false, false, false, 
  false, false, false, 
  false, false, false, 
  false, false, false
};

int  w = 1000, h = 1000;

int x = w/2;
int y = h/2;
int z = 0;
float intervalo = w /12;
color c;
void setup() {
  size(w, h, OPENGL);
  background(255);
  noFill();

  miPuerto = new Serial(this, "COM8", 9600);
  miPuerto.bufferUntil('\n');
}

void draw() {
  background(255);

  for (float i = 0; i <=w-20; i+=intervalo) {
    inByte[int(i/intervalo)] = map(inByte[int(i/intervalo)], 0, 1400, 0, 100);
    ellipse(i+50, h / 2, inByte[int(i/intervalo)]/2, inByte[int(i/intervalo)]/2);
    //println(inByte[int(i/intervalo)], i / intervalo);
  }

  accion();
  // background(255);
}

boolean revisionEstado(int c) {

  if (inByte[c] >= 1000) {//Si val del ldr es mayor a mil true
    actividad[c] = true;
  } else if (inByte[c] <= 600) { // si es menor a 600  false
    actividad[c] = false;
  } 
  return actividad[c];
}

void accion() {
  for ( int butNum = 0; butNum < 12; butNum++ ) {
    println("Sensor # ", butNum, revisionEstado(butNum) );//Actualiza el estado del sensor
    //println( "Sensor Activo", butNum, actividad[butNum] );
    if ( actividad[butNum] ) { //Si el sensor esta activo aplica switch
      //println("accion");

      switch(butNum) {
      case 0:
        fill(255, 0, 0);
        break;
      case 1:
        fill(255, 0, 0);
        break;
      case 2:
        fill(255, 0, 0);
        break;
      case 3:
        fill(0, 255, 0);
        break;

      case 4:
        fill(0, 255, 0);
        break;
      case 5:
        fill(0, 255, 0);
        break;

      case 6:
        fill(0, 0, 255);
        break;
      case 7:
        fill(0, 0, 255);
        break;
      case 8:
        fill(0, 0, 255);
        break;

      case 9:
        fill(255, 0, 255);
        break;
      case 10:
        fill(255, 0, 255);
        break;
      case 11:
        fill(255, 0, 255);
        break;
      }
    } else if(!actividad[0] && !actividad[1] && !actividad[2] &&
              !actividad[3] && !actividad[4] && !actividad[5] && 
              !actividad[6] && !actividad[7] && !actividad[8] && 
              !actividad[9] && !actividad[10] && !actividad[11])    {
                println("Todo Apagado");
     fill(255); 
    }
    
  }
}

void serialEvent(Serial miPuerto) {

  String inString = miPuerto.readStringUntil('\n');

  if (inString != null) {

    inString = trim( inString );

    inByte = float( split( inString, ",") );

    // println(inByte);
  }
}

