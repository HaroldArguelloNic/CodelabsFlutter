int addThreeValues({  //la declaracion de los parametros requeridos es obligatorio
  required int first,  //declaracion de parametro requerido
  required int second,  //declaracion de parametro requerido
  int third = 0,   //declaracion de parametro con valor 0
}) {
  return first+second+third;   //retorno de la suma de los parametros
}

void main(){
  final sum = addThreeValues(   //llamada a la funcion con argumentos obligatorios
    first: 2,  //asignacion de valor a los parametros
    second: 5,  //asignacion de valor a los parametros
 //   third: 3,  //asignacion de valos a los parametros
  );
  print(sum);
}