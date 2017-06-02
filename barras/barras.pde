//Taller "Arte con Datos"
//Mateus Knelsen
//MedialabMX - Mayo/2017
//Ejercício de visualización de datos con barras

//Array para almacenar numeros de la tabla:
int[] numeros = new int[0];

//Fuente para visualizar los valores presentes en
//las lineas de la tabla:
PFont fuente;

//Anchura fija de cada una de las barras:
int anchura = 12;

void setup(){
  size(1200, 100);
  background(0);
   
  //Creando un objeto de tipo "tabla", para cargar el archivo .csv:
  Table tabla = loadTable("numeros.csv", "header");
  
  //Atrubuyendo una fuente al objeto "fuente":
  fuente = loadFont("SourceSansPro-Light-12.vlw");
  textFont(fuente, 12);
  
  //"for loop" para extraer los números enteros de las líneas de la tabla:
  for(TableRow linea : tabla.rows()){
    int numero = linea.getInt("numero");
    numeros = append(numeros, numero);
  }
  
  println(numeros);
  noStroke();
}

void draw(){
  //Variable para cambiar la posición en x de cada una de las barras:
  int dx = 0;
  
  //"for loop" para dibujar un rectángulo para cada uno de los
  //numeros que tenemos en el array de enteros:
  for(int i = 0; i < numeros.length; i++){
    //mapeo de cada uno de los valores
    //de la tabla en un valor de color verde. Cuanto más verde,
    //más amarillo será el color de la barra:
    float G = map(numeros[i], 
              min(numeros), 
              max(numeros),
              0,
              255);
        
    fill(255, G, 0);
    
    //Por fin, dibujando el rectángulo. 
    rect(dx, height, anchura, -numeros[i]);
    
    fill(0);
    
    //Dibujando el valor correspondiente a la barra
    //en formato de texto:
    text(numeros[i], dx, height - 10);
    
    //Añadiendo un valor fijo a nuestra variable
    //que utilizamos para ubicar el rectángulo
    //en el eje x:
    dx = dx + anchura;
    // se puede abreviar como dx += 10;
  }
}