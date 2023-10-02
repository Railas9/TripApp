import 'package:flutter/material.dart';

class CityBanner extends StatelessWidget {
  final String cityName;
  final String cityImage;
  const CityBanner({Key? key, required this.cityName, required this.cityImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(tag: cityName, child: Image.network(cityImage, fit: BoxFit.cover))
          ,
          Container(
            color: Colors.black38,
            child: Center(
              child: Text(cityName, style: const TextStyle(color: Colors.white, fontSize: 20),),
            ),
          )

        ],
      ),
    );
  }
}
