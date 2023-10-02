import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/widgets/trip_loader.dart';

class WeatherTrip extends StatelessWidget {
  final String cityName;
  final String hostBase = "https://api.openweathermap.org/data/2.5/weather?q=";
  final String apiKey = "&appid=4499ec8d125ca63505b46811e95d84d9";

   const WeatherTrip({Key? key, required this.cityName}) : super(key: key);

   Future<String> get getWeather {
     return http.get(Uri.parse('$hostBase$cityName$apiKey'))
         .then((response){
               Map<String, dynamic> body = jsonDecode(response.body);
               return body['weather'][0]['icon'] as String;
         }).catchError((e)=> 'error');

   }

   String getIconUrl(String iconName){
     return "https://openweathermap.org/img/wn/$iconName@2x.png";
   }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getWeather, builder: (_,snapshot){
      if(snapshot.hasData){
        return
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Météo',
                  style: TextStyle(fontSize: 20),
                ),
                Image.network(
                  getIconUrl(snapshot.data as String),
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          );
      }
      else if(snapshot.hasError){
        return const Text("erreur");
      }
      else{
        return const TripLoader();
      }
    });
  }
}
