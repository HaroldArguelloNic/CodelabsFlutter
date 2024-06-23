class Meal {
  late String description;

  void setDescription(String str){
    description = str;
  }
  
}
// se asigna valor a la instancia de clase antes de leerlo
void main(){
  final myMeal= Meal();
  myMeal.setDescription('Feijoada');// se asigna valor a la instancia de clase antes de leerlo
  print(myMeal.description);
}