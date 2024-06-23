import 'dart:math';

class StringProviderFactory {
  static StringProvider getprovider()=> RandomStringProvider();
}

class StringProvider {

  String? value='Hi!';
  
}

 class RandomStringProvider extends StringProvider{ //herencia de la clase StringProvider
   String? get value =>
   Random().nextBool() ? 'A string' : null;
 }

void printString(String str) =>print(str);

void main(){
  final provider = StringProviderFactory.getprovider(); //obtiene el valor de RandomStringProvider
  
  final str = provider.value; //almacena el valor generado RandomStringProvider 

  if(str == null) {
    print(provider.value == null);
  } else {
    print('the value is not null, so print it!');
    printString(str);
  }
}