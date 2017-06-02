//Taller "Arte con Datos"
//Mateus Knelsen
//MedialabMX - Mayo/2017
//Ejercício de visualización de datos de crímenes en la CDMX - v1

//Creando un ArrayList (lista de objetos) para almacenar nuestras
//instancias de la clase "Crimen":
ArrayList<Crimen> crimenes = new ArrayList<Crimen>();

void setup(){
  size(1200, 800);
  
  //Cargando la tabla de datos en una instancia del objeto "Table":
  Table tabla = loadTable("crime-lat-long.csv", 
                          "header");
  
  //"for loop" para recorrermos las líneas de la tabla:
  for(TableRow linea : tabla.rows()){
    //Estableciendo una condicional:
    //apenas vamos a generar instancias de "Crimen"
    //si el año del crimen (en la base) es 2013
    //y si el mes es 1 (enero):
    if(linea.getInt("year") == 2013 && 
       linea.getInt("month") == 1){
         
         //Aquí tenemos que "romper" con una String que
         //contiene los numeros que se refieren a la fecha
         //del crimen. Para eso usamos el metodo "split",
         //que divide una string en un array de strings con
         //base en un caracter divisor que contiene la string
         //que se está rompiendo:
         String fecha = linea.getString("date");
         String[] f = split(fecha, "-");
         
         println(f);
         
         //Ejecutando un "casting", es decir, convertiendo las
         //strings del dia, mes y año en números enteros:
         int dia = int(f[2]);
         int mes = int(f[1]);
         int ano = int(f[0]);
         
         //Similar a lo que hicimos arriba para la fecha, repetimos
         //ahora para el horario del crimen:
         String horario = linea.getString("hour");
         String[] h = split(horario, ":");
         int hora = int(h[0]);
         int minuto = int(h[1]);
         
         //Generando una instancia del objeto Crimen:
         Crimen c = new Crimen(linea.getString("crime"),
                               dia,
                               mes,
                               ano,
                               hora,
                               minuto);
      
      //Añadiendo el objeto al ArrayList:
      crimenes.add(c);
    }
    else{
      break;
    }
  }
}

void draw(){
  //"for loop" en nuestro ArrayList:
  for(int i = 0; i < crimenes.size(); i++){
    //Condicional: si el tipo de crimen contiene la palabra "ROBO"...
    if(crimenes.get(i).tipoCrimen.indexOf("ROBO") > -1){
      //... entonces ejecutamos una función que está declarada
      //en nuestra clase Crimen:
      crimenes.get(i).dibujarMinuto(random(width),
                                    random(height));
    }
  }
}