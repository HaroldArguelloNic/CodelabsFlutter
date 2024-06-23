import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
  const String appTitle = 'Flutter Layout Demo';
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(       //llamada a la instacia de clase que contendra la imagen
                image: 'assets/images/lake.jpg' //ruta y nombre de imagen pasada por parametro
                ),
              TitleSection(
                name: 'Camping del lago Oeschinen',
                location: 'Kandersteg, Suiza',
                ),
              ButtonSection(),    //llamada a la instancia de botones
              TextSection(
                description:  'El lago Oeschinen se encuentra al pie del Blüemlisalp en el '
                              'Alpes de Berna. Situado a 1.578 metros sobre el nivel del mar, '
                              'Es uno de los lagos alpinos más grandes. Un paseo en góndola desde '
                              'Kandersteg, seguido de un paseo de media hora por los pastos '
                              'y bosque de pinos, te lleva al lago, que se calienta a 20 '
                              'grados Celsius en el verano. Actividades disfrutadas aquí '
                              'incluyen remo y paseos en trineo de verano.',
                )
            ],
          ),
        ),
      ),
    );
  }
}

  class TitleSection extends StatelessWidget {
    const TitleSection({
          super.key,
          required this.name,
          required this.location,            
          });
      final String name;
      final String location;
  
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              /* 1 */
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* 2 */
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    location,
                      style: TextStyle(
                        color: Colors.grey[500],
                      )
                  ),
                ],
              )
            ),
            const Icon(
              Icons.star,
              color: Colors.red,
            ),
            const Text('41'),
          ],
        ),
        );
    }
  }

  class ButtonSection extends StatelessWidget {
    const ButtonSection({super.key});
  
    @override
    Widget build(BuildContext context) {
      final Color color = Theme.of(context).primaryColor;
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtoWithText(
              color: color,
              icon: Icons.call,
              label: 'CALL'
            ),
            ButtoWithText(
              color: color,
              icon: Icons.near_me,
              label: 'ROUTE'
            ),
            ButtoWithText(
              color: color,
              icon: Icons.share,
              label: 'SHARE'
            ),
          ],
        ),
      );
    }
  }

  class ButtoWithText extends StatelessWidget {
    const ButtoWithText({
      super.key,
      required this.color,
      required this.icon,
      required this.label
      });

      final Color color;
      final IconData icon;
      final String label;
  
    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color,),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
              ),
            ),
        ],
      );
    }
  }

  class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}