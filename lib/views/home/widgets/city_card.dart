import 'package:flutter/material.dart';

import '../../../models/city_model.dart';

class CityCard extends StatelessWidget {

  final City city;


  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(tag: city.name, child:
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                    context,
                    "/city",
                    arguments: city.name);
              },
              child: Image.network(city.image, fit: BoxFit.cover),
            )
            )
              ,
            Positioned(
              top: 10,
              left: 10,
              child:
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black54,
              child: Text(city.name, style: const TextStyle(color: Colors.white, fontSize: 30))
            ),
            )
          ],
        ),
      ), // utilisation de container pour definir une hauteur
    );
  }
}
