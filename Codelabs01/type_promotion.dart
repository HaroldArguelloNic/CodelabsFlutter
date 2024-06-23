void main(){

  // Object a = 'this is a string';
  // if(a is String) { //promociona el tipo de dato basico a string
  // print(a.length);
  // }
   String? text;

  if(DateTime.now().hour < 12) {  //condicion de asignacion en dependencia de la hora
    text= "It's morning!, let's make aloo paratha!"; // se asigna valor a la variable de tipo string
  } else {
    text= "It's afternoon! let's make biryani!"; // se asigna valor a la variable de tipo string
  }

  print(text);
  print(text.length); //imprime el largo de la cadena de texto
}