int getLength(String? str) {
  // add null check here
  if(str == null){
    throw 'Hey, that string was null'; //retorna la exception
  }

  return str.length;

}

void main(){
  print(getLength(null));
}