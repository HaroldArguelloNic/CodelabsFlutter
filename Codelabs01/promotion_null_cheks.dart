
int getLength(String? str) {
  // add null check here
  if(str== null){ // chequea que la variable no sea nula.
    return 0;
  }


  return str.length;

}

void main(){
  print(getLength('this is a string'));
}