// nullable type parameters


void main(){
  List<String> aListOfStrings = ['one','two','three'];
  List<String>? aNullableListOfStrings;
  List<String?> aListOfNullableStrings = ['one',null,'three'];

print('aListOfStrings $aListOfStrings');
print('aNullableListOfStrings $aNullableListOfStrings');
print('aListOfNullableStrings $aListOfNullableStrings');
}
