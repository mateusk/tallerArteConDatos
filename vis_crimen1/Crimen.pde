//Esta es una clase que estamos usando para almacenar la información
//que se refieren a cada uno de los crímenes en la base de datos.

//Declaración de la clase:
class Crimen{
  
  //Propriedades del objeto que genera la clase:
  String tipoCrimen;
  int dia;
  int mes;
  int ano;
  int hora;
  int minuto;
  
  //Constructor: esta es la función que ejecutamos
  //para generar instancias del objeto "Crimen".
  //El constructor tiene como parámetros
  //los datos que necesitamos para inicializar
  //las propriedades de cada instancia de este objeto:
  Crimen(String _tipoCrimen,
         int _dia,
         int _mes,
         int _ano,
         int _hora,
         int _minuto
  ){
    tipoCrimen = _tipoCrimen;
    dia = _dia;
    mes = _mes;
    ano = _ano;
    hora = _hora;
    minuto = _minuto;
  };
  
  //Función específica de esta clase para dibujar
  //un círculo cuyo radio se refiere al valor
  //del minuto en que el crimen fue registrado:
  void dibujarMinuto(float x, float y){
    fill(255);
    ellipse(x, y, minuto, minuto);
  }
}