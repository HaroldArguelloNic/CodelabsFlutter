int _ComputeValue() {
  print('In _ComputeValue....');
  return 3;
}

class CachedValueProvider {
  late final _cache = _ComputeValue(); //ejecuta la funcion _ComputeValue
  int get value => _cache;
}

void main() {
  print('calling contructor ....');
  var provider = CachedValueProvider(); //instancia de la clase CachedValueProcider
  print('getting value ....');
  print('The value is ${provider.value}');
}