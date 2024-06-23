import 'package:flutter/material.dart';

void main() {
  runApp(const DogApp());
}

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dog App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yellow Lab'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DogName('Rocky'), //instanciacion de la clase se para por parametro un string
              SizedBox(height: 8,),
              DogName('Lyla'),
              SizedBox(height: 8,),
              DogName('Nico'),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }
}

class DogName extends StatelessWidget {
  
  final String name; //declaracion de variable

const DogName(this.name, {super.key}); //declaracion de un constructor

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.lightBlueAccent,),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(name),
      ),
    );
  }
}
  
