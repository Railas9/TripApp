import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/providers/city_provider.dart';
import 'package:travel_app/views/trip/widgets/trip_bar_city.dart';
import 'package:travel_app/views/trip/widgets/trip_list_activity.dart';
import 'package:travel_app/views/trip/widgets/weather_trip.dart';



class TripView extends StatelessWidget {
  static const tag =  "/trip";
  const TripView({super.key});


  @override
  Widget build(BuildContext context) {

    final String? tripId = (ModalRoute.of(context)!.settings.arguments as Map<String,String?>)["tripId"];
    final String? cityName = (ModalRoute.of(context)!.settings.arguments as Map<String,String?>)["cityName"];
    final City city = Provider.of<CityProvider>(context, listen: false).getCityByName(cityName!);

    return Scaffold(
      body:
      SingleChildScrollView(
       child: Column(
         children: [
           TripViewBar(city: city),
           WeatherTrip(cityName: city.name),
           TripListActivity(tripId: tripId)
         ],
       ),
      )

    );
  }
}
