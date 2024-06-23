//The null assertion operator (:)
// Signo de afirmacion nula (!)
 int? couldReturnNullButDoesnt()=> -3;
 int? couldBeNullButIsnt = 1;

 void main(){

 List<int?> listThatCouldHoldNulls= [2,null,4];

   int a = couldBeNullButIsnt!;
   int b = listThatCouldHoldNulls.first!;  //first item in the list
   int c = couldReturnNullButDoesnt()!.abs();  //absolute value

   print('a is $a');
   print('b is $b');
   print('c is $c');

 }