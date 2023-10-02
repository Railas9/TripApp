import 'package:flutter/material.dart';
import '../../../models/city_model.dart';

class TripViewBar extends StatelessWidget {
  final City city;
  const TripViewBar({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("ACTIVITY bar");
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(city.image, fit: BoxFit.cover),
          Container(
            padding: const EdgeInsets.only(top: 40),
            color: Colors.black38,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.white,
                    )
                    )
                  ],
                ),
                Expanded(
                    child:
                    Center(
                      child: Text(city.name, style: const TextStyle(color: Colors.white, fontSize: 20),),
                    ))
              ],
            ),
          )

        ],
      ),
    );
  }
}
