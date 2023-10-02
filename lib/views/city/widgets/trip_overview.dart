import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/views/city/widgets/city_banner.dart';
import '../../../models/trip_model.dart';

class TripOverview extends StatelessWidget {
  final Trip myTrip;
  final VoidCallback setDate;
  final String cityName;
  final String cityImage;
  final double? amount;

  const TripOverview({Key? key,required this.myTrip, required this.setDate, required this.cityName, required this.amount, required this.cityImage}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: orientation == Orientation.landscape ? size.width * 0.5 : size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           CityBanner(cityName: cityName, cityImage: cityImage),
              Padding(
                  padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child:
                    Text(
                        myTrip.date != null ?
                        DateFormat("d/M/y").format(myTrip.date!)
                            : "choisissez une date"
                        , style : const TextStyle(fontSize: 20))
                    ),
                    ElevatedButton(onPressed: setDate, child: const Text("Selectionner une date"))
                  ],
                ),
              ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(child: Text("Montant / personne", style: TextStyle(fontSize: 20),
                )
                ),
                Text("$amount \$", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
