//Taller "Arte con Datos"
//Mateus Knelsen
//MedialabMX - Mayo y Junio/2017
//Ejercício de visualización de datos de crímenes en la CDMX - v2

//Aquí declaramos un array de strings que contiene los tipos de crimenes
//que serán utilizados para realizar búsquedas en la tabla:
String[] filtrosTipoCrimen = {"ROBO A TRANSEUNTE C.V.",
                              "ROBO A REPARTIDOR S.V.",
                              "ROBO A NEGOCIO C.V.",
                              "ROBO DE VEHICULO AUTOMOTOR S.V.",
                              "ROBO A BORDO DE MICROBUS S.V.",
                              "ROBO A BORDO DE METRO S.V.",
                              "LESIONES POR ARMA DE FUEGO",
                              "HOMICIDIO DOLOSO",
                              "VIOLACION"
                              };

//Esta es una variable que usamos para seleccionar un item
//del array de tipos de crimenes. El valor de esta variable se
//va a cambiar con las teclas izquierda y derecha del teclado:
int indFiltro = 0;

//Variable que contiene el número del año de analisis para 
//realizarmos búsqueda de datos en la tabla. También cambiaremos
//este número con el teclado:
int anoAnalisis = 2013;

//Variables para almacenar las cantidades de ocurrencias del tipo
//de crimen en analisis para cada mes, lo maximo y lo minimo en el
//año, y el total de crimenes en el año:
float numCrimenesEne = 0;
float numCrimenesFeb = 0;
float numCrimenesMar = 0;
float numCrimenesAbr = 0;
float numCrimenesMay = 0;
float numCrimenesJun = 0;
float numCrimenesJul = 0;
float numCrimenesAgo = 0;
float numCrimenesSep = 0;
float numCrimenesOct = 0;
float numCrimenesNov = 0;
float numCrimenesDic = 0;

float maxCrimenesMes = 0;
float minCrimenesMes = 0;

float totalCrimenes = 0;

PFont texto;

//Nuestra instáncia del objeto Table, para almacenar los datos de la tabla:
Table tabla;

void setup(){
  size(800, 800);
  
  //Cargando la tabla de datos en una instancia del objeto "Table":
  tabla = loadTable("crime-lat-long.csv", "header");
  
  //Esta es una función que carga los datos de la tabla y "rellena"
  //las variables que declaramos arriba con las cantidades de ocurrencias 
  //del crimen en analisis (dale un scroll hacia abajo para ver la declaración
  //de la función):
  cargarDatos(anoAnalisis);
  
  //Este método sirve para aplicar antialiasing en el rendering de las
  //formas graficas:
  smooth();
  
  //Preparando una fuente de texto para visualizar los nombres de los meses,
  //cantidades de crimenes, año de analisis, etc.
  texto = loadFont("Helvetica-Light-48.vlw");
  textFont(texto, 48);
}

void draw(){  
  
  background(0);
  
  //Variables para dibujarmos los arcos que indican las cantidades de crimenes,
  //más adelante:
  float anchura = 0;
  float altura = 0;
  float anguloInicial = 0;
  float anguloFinal = 0;
  
  float R = 0;
  float B = 0;
  
  //ellipseMode(CENTER) nos permite dibujar los arcos desde el centro del
  //circulo del cual son parte. strokeCap(SQUARE) hace con que el acabado
  //de las puntas de los arcos sea plano.
  ellipseMode(CENTER);
  strokeCap(SQUARE);
  
  //for loop para dibujar los arcos, líneas de división y los textos que
  //se refieren a los datos de ocurrencias del crimen en los 12 meses del año:
  for(int i = 0; i < 12; i++){
    
    //Vamos a dibujar los textos primero, por lo tanto, les damos un color gris:
    fill(180);
    
    //Dos variables para dar la posición x e y del texto que se refiere
    //a los meses del año y la cantidad de ocurrencias del tipo de crimen
    //a cada mes. Estes textos son distribuidos al largo de una circunferencia,
    //y para hacer más fácil esta distribuición, usamos las ecuaciones abajo.
    //Estas ecuaciones están basadas en el punto central de la pantalla (width/2
    //y height/2), a este punto sumamos o subtrayemos una distáncia que es
    //12 * 180 grados, divididos por dos PI (una circunferencia completa tiene
    //dos PI radianos de largo), y multiplicados por el seno o coseno
    //de un ángulo que es el indice actual del for loop (i) veces dos PI divido
    //por 12 menos PI dividido por 2.4:
    float x = width/2 + ((12 * 180)/TWO_PI) * cos(i * TWO_PI/12 - (PI / 2.4));
    float y = height/2 + ((12 * 180)/TWO_PI) * sin(i * TWO_PI/12 - (PI / 2.4));
    textAlign(CENTER);
    textSize(18);
    
    //Aquí aplicamos un switch case. Es como una condicional en la cual estableces
    //los casos específicos posibles. Aquí estamos aplicando este switch case
    //para ejecutar distintas operaciones dependiendo del valor de i:
    switch(i){
   case 0:
     //Primero, dibujamos el texto que dice cual es el més que se refiere el arco,
     //y luego abajo, un texto que contiene el número de ocurrencias del crimen en
     //ese mes:
     text("Enero", x, y);
     text(int(numCrimenesEne), x, y + 30);
     
     //La anchura y la altura del círculo que describe el arco deben ser iguales,
     //por eso igualamos los dos al resultado de un mapeo que convierte la cantidad
     //de crimenes de este mes, con referencia al minimo y al maximo de crimenes
     //en el año, para un valor entre la mitad de la anchura de la pantalla y 
     //las dos de tres partes de la misma anchura:
     anchura = altura = map(numCrimenesEne, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     
     //Cada arco necesita de un angulo inicial y un angulo final. El cada caso, vamos a cambiar
     //estos angulos dependiendo del mes. Aquí estamos estableciendo los valores de los angulos
     //en grados, convertidos en radianos:
     anguloInicial = radians(270);
     anguloFinal = radians(300);
     
     //Aquí dibujamos las líneas divisoras entre los arcos. Para hacer más fácil la tarea,
     //aplicamos un push/popMatrix. Estas funciones establecen translaciones que solamente
     //son validas para lo que es dibujado entre las funciones. Así, podemos dibujar la línea
     //como si fuera una línea recta, aplicandole una rotación equivalente al angulo final
     //del arco:
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(300));
     line(150, 0, 400, 0);
     popMatrix();
     
     //Ahora tenemos tres mapeos. El primero convierte la cantidad de ocurrencias del crimen
     //en un strokeWeight - grosura de línea -  de 3 a 50 pixeles, que vamos aplicar a los
     //arcos. Los otros dos mapeos generan valores de canales de color rojo y azul. Fijese
     //que en el mapeo para el color azul (B), invertimos los últimos dos valores de
     //parametros. Así lo hacemos porque queremos generar una relación inversa entre el
     //azul y el rojo: cuanto más cerca está la cantidad de ocurrencias en este mes de 
     //la cantidad máxima de crimenes en un mes, más rojo será el arco. Cuanto menor la
     //cantidad, más azul:
     
     strokeWeight(map(numCrimenesEne, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesEne, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesEne, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     //un break para salir del switch case sin evaluar los otros casos (si este es el caso
     //valido, no hace falta recorrer los otros casos posibles)
     break;
     
   case 1:
     text("Febrero", x, y);
     text(int(numCrimenesFeb), x, y + 30);
             
     anchura = altura = map(numCrimenesFeb, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(300);
     anguloFinal = radians(330); 
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(330));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesFeb, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesFeb, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesFeb, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 2:
     text("Marzo", x, y);
     text(int(numCrimenesMar), x, y + 30);
     
     anchura = altura = map(numCrimenesMar, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(330);
     anguloFinal = radians(360);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesMar, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesMar, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesMar, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 3:
     text("Abril", x, y);
     text(int(numCrimenesAbr), x, y + 30);
     
     anchura = altura = map(numCrimenesAbr, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(0);
     anguloFinal = radians(30); 
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(30));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesAbr, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesAbr, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesAbr, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 4:
     text("Mayo", x, y);
     text(int(numCrimenesMay), x, y + 30);
     
     anchura = altura = map(numCrimenesMay, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(30);
     anguloFinal = radians(60);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(60));
     line(150, 0, 400, 0);
     popMatrix();
     
     strokeWeight(map(numCrimenesMay, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesMay, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesMay, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 5:
     text("Junio", x, y);
     text(int(numCrimenesJun), x, y + 30);
     
     anchura = altura = map(numCrimenesJun, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(60);
     anguloFinal = radians(90);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(90));
     line(150, 0, 400, 0);
     popMatrix();
     
     strokeWeight(map(numCrimenesJun, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesJun, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesJun, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
   
   case 6:
     text("Julio", x, y);
     text(int(numCrimenesJul), x, y + 30);
     
     anchura = altura = map(numCrimenesJul, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(90);
     anguloFinal = radians(120);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(120));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesJul, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesJul, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesJul, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
   
   case 7:
     text("Agosto", x, y);
     text(int(numCrimenesAgo), x, y + 30);
     
     anchura = altura = map(numCrimenesAgo, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(120);
     anguloFinal = radians(150);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(150));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesAgo, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesAgo, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesAgo, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 8:
     text("Septiembre", x, y);
     text(int(numCrimenesSep), x, y + 30);
     
     anchura = altura = map(numCrimenesSep, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(150);
     anguloFinal = radians(180);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(180));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesSep, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesSep, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesSep, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 9:
     text("Octubre", x, y);
     text(int(numCrimenesOct), x, y + 30);
     
     anchura = altura = map(numCrimenesOct, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(180);
     anguloFinal = radians(210);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(210));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesOct, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesOct, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesOct, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
   
   case 10:
     text("Noviembre", x, y);
     text(int(numCrimenesNov), x, y + 30);
     
     anchura = altura = map(numCrimenesNov, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(210);
     anguloFinal = radians(240);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(240));
     line(150, 0, 400, 0);
     popMatrix();
  
     strokeWeight(map(numCrimenesNov, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesNov, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesNov, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
     
   case 11:
     text("Diciembre", x, y);
     text(int(numCrimenesDic), x, y + 30);
     
     anchura = altura = map(numCrimenesDic, minCrimenesMes, maxCrimenesMes, width/2, width/1.5);
     anguloInicial = radians(240);
     anguloFinal = radians(270);
     
     strokeWeight(1);
     stroke(127);
     pushMatrix();
     translate(width/2, height/2);
     rotate(radians(270));
     line(150, 0, 400, 0);
     popMatrix();
     
     strokeWeight(map(numCrimenesDic, minCrimenesMes, maxCrimenesMes, 3, 50));
     
     R = map(numCrimenesDic, minCrimenesMes, maxCrimenesMes, 0, 255);
     B = map(numCrimenesDic, minCrimenesMes, maxCrimenesMes, 255, 0);
     
     break;
   
   default:
     break;
   }
     
    //Finalmente, una vez que tenemos el arco de este loop configurado,
    //podemos dibujarlo:
    noFill();
    stroke(R, 0, B);
    arc(width/2,
        height/2,
        anchura,
        altura,
        anguloInicial,
        anguloFinal);
  }
  
  //Ahora dibujamos los textos que están en el centro de la visualización:
  noStroke();
  
  fill(180);
  textAlign(CENTER);
  textSize(24);
  text("Crimenes en la CDMX", width/2, height/2 - 70);
  
  fill(255);
  textAlign(CENTER);
  textSize(48);
  text(anoAnalisis, width/2, height/2);
  
  fill(180);
  textAlign(CENTER);
  textSize(24);
  text(filtrosTipoCrimen[indFiltro], width/2, height/2 + 60);
  
  textAlign(CENTER);
  textSize(16);
  text("Total de ocurrencias en el año: " + int(totalCrimenes), width/2, height/2 + 100);
}

//Esta es la función responsable por cargar los datos de la tabla:
void cargarDatos(int anoAnalisis){
  println("Cargando datos de " + anoAnalisis + "...");
  
  //"Limpiando" los valores de las variables que contienen las cantidades de ocurrencias:
  numCrimenesEne = 0;
  numCrimenesFeb = 0;
  numCrimenesMar = 0;
  numCrimenesAbr = 0;
  numCrimenesMay = 0;
  numCrimenesJun = 0;
  numCrimenesJul = 0;
  numCrimenesAgo = 0;
  numCrimenesSep = 0;
  numCrimenesOct = 0;
  numCrimenesNov = 0;
  numCrimenesDic = 0;

  maxCrimenesMes = 0;
  minCrimenesMes = 0;
  
  //"for loop" para recorrermos las líneas de la tabla que contienen el tipo
  //de crimen que estamos buscando en la columna "crime". El tipo de crimen
  //se encuentra en el array filtrosTipoCrimen, en el indice indFiltro:
  for(TableRow linea : tabla.findRows(filtrosTipoCrimen[indFiltro], "crime")){
    //Si el año de esta linea corresponde al año establecido para el analisis...
    if(linea.getInt("year") == anoAnalisis){
     //"Rompiendo" con la string que contiene la fecha del crimen:
     String fecha = linea.getString("date");
     String[] f = split(fecha, "-");
        
     //Ejecutando un "casting", es decir, convertiendo las
     //strings del dia, mes y año en números enteros:
     int mes = int(f[1]);
     
     //Para contabilizar la cantidad de crimenes por mes,
     //hacemos un switch case con referencia al numer de este mes,
     //sumando uno a la variable correspondiente:
     switch(mes){
       case 1:
         numCrimenesEne++;
         break;
       case 2:
         numCrimenesFeb++;
         break;
       case 3:
         numCrimenesMar++;
         break;
       case 4:
         numCrimenesAbr++;
         break;
       case 5:
         numCrimenesMay++;
         break;
       case 6:
         numCrimenesJun++;
         break;
       case 7:
         numCrimenesJul++;
         break;
       case 8:
         numCrimenesAgo++;
         break;
       case 9:
         numCrimenesSep++;
         break;
       case 10:
         numCrimenesOct++;
         break;
       case 11:
         numCrimenesNov++;
         break;
       case 12:
         numCrimenesDic++;
         break;
       default:
         break;
     }
    }
  }
  
  //Acá creamos un array con las cantidades de ocurrencias
  //por mes. Este array sirve solamente para calcular el valor maximo
  //y el valor minimo de crimenes en un mes:
  int[] crimenesAno = {int(numCrimenesEne), 
                       int(numCrimenesFeb),
                       int(numCrimenesMar),
                       int(numCrimenesAbr),
                       int(numCrimenesMay),
                       int(numCrimenesJun),
                       int(numCrimenesJul),
                       int(numCrimenesAgo),
                       int(numCrimenesSep),
                       int(numCrimenesOct),
                       int(numCrimenesNov),
                       int(numCrimenesDic)};
  
  maxCrimenesMes = max(crimenesAno);
  minCrimenesMes = min(crimenesAno);
  
  //Sumando todas las cantidades mensuales para tener un total anual
  //de ocurrencias:
  totalCrimenes = int(numCrimenesEne) +  
                  int(numCrimenesFeb) +
                  int(numCrimenesMar) +
                  int(numCrimenesAbr) +
                  int(numCrimenesMay) +
                  int(numCrimenesJun) +
                  int(numCrimenesJul) +
                  int(numCrimenesAgo) +
                  int(numCrimenesSep) +
                  int(numCrimenesOct) +
                  int(numCrimenesNov) +
                  int(numCrimenesDic);
  
  println("Tenemos " + totalCrimenes + " crimenes en el año de " + anoAnalisis + " del tipo: " + filtrosTipoCrimen[indFiltro]);
  println("Tenemos " + numCrimenesEne + " crimenes en Enero");
  println("Tenemos " + numCrimenesFeb + " crimenes en Febrero");
  println("Tenemos " + numCrimenesMar + " crimenes en Marzo");
  println("Tenemos " + numCrimenesAbr + " crimenes en Abril");
  println("Tenemos " + numCrimenesMay + " crimenes en Mayo");
  println("Tenemos " + numCrimenesJun + " crimenes en Junio");
  println("Tenemos " + numCrimenesJul + " crimenes en Julio");
  println("Tenemos " + numCrimenesAgo + " crimenes en Agosto");
  println("Tenemos " + numCrimenesSep + " crimenes en Septiembre");
  println("Tenemos " + numCrimenesOct + " crimenes en Octubre");
  println("Tenemos " + numCrimenesNov + " crimenes en Noviembre");
  println("Tenemos " + numCrimenesDic + " crimenes en Diciembre");
  
  println("El mes con más crimenes tuvo " + int(maxCrimenesMes) + " ocurrencias");
  
  println("---------------------------------------------------------------");
  println("");
}

//Esta función en Processing verifica a cada loop de la aplicación si una tecla
//del teclado fue presionada:
void keyPressed() {
  //Si la tecla presionada fué la flecha para arriba, vamos a cambiar el año
  //de analisis a 2014:
  if (keyCode == UP) {
    anoAnalisis = 2014;
  } 
  
  //Si la tecla presionada fué la flecha para abajo, vamos a cambiar el año
  //de analisis a 2013:
  if (keyCode == DOWN) {
    anoAnalisis = 2013;
  }
  
  //Si la tecla presionada fué la flecha para la derecha, vamos a sumar 1 a la
  //variable que dice que item de la lista de tipos de crimen estamos buscando:
  if(keyCode == RIGHT){
    indFiltro++;
    
    //Este if no permite que el valor de indFiltro sea mayor que la cantidad
    //de tipos de crimen:
    if(indFiltro >= filtrosTipoCrimen.length){
      indFiltro = filtrosTipoCrimen.length - 1;
    }
  }
  
  //Si la tecla presionada fué la flecha para la izquierda, vamos a subtraer 1
  //de indFiltro: 
  if(keyCode == LEFT){
    indFiltro--;
    
    //Este if no permite que el valor de indFiltro sea menor que cero:
    if(indFiltro <= 0){
      indFiltro = 0;
    }
  }
  
  //Si las teclas del teclado fueran presionadas, entonces vamos actualizar los
  //datos de la visualización:
  cargarDatos(anoAnalisis);
}