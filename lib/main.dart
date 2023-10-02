import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/city_provider.dart';
import 'package:travel_app/providers/trip_provider.dart';
import 'package:travel_app/views/404/not_found_views.dart';
import 'package:travel_app/views/activity_form/activity_form_view.dart';
import 'package:travel_app/views/city/city_view.dart';
import 'package:travel_app/views/home/home_view.dart';
import 'package:travel_app/views/trip/trip_view.dart';
import 'package:travel_app/views/trips/trips_view.dart';


main(){
  runApp(const TravelApp());
}


class TravelApp extends StatefulWidget{


  const TravelApp({super.key});

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {

  /*
  List<Trip> trips = [];

  void addTrip(Trip trip){
    setState(() {
      trips.add(trip);
    });
  }
*/

  CityProvider cityProvider = CityProvider();
  TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchCities();
    tripProvider.fetchTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MultiProvider(providers: [
        ChangeNotifierProvider.value(value: cityProvider),
        ChangeNotifierProvider.value(value: tripProvider)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeView.tag: (context) => const HomeView(),
          CityView.tag: (context) => const CityView(),
          TripsView.tag: (context) => const TripsView(),
          TripView.tag: (context) => const TripView(),
          ActivityFormView.tag: (context) => const ActivityFormView()
        },
        /*
      onGenerateRoute: (settings){
        switch (settings.name){
          case CityView.tag :
            return MaterialPageRoute(builder: (context){
              final City city = settings.arguments as City;
              return CityView(city: city, addTrip: addTrip,);
            });
          case TripsView.tag:
            return MaterialPageRoute(builder: (context){
              return TripsView(trips: trips,);
            });
          case TripView.tag:
            return MaterialPageRoute(builder: (context){
               String? cityName = (settings.arguments as Map<String,String>)["cityName"];
               String? tripId = (settings.arguments as Map<String,String>)["tripId"];

              return TripView(
                city: widget.cities.firstWhere((element) => element.name == cityName)
                , trip: trips.firstWhere((element) => element.id == tripId)
                );
            });
        }
      },
      */

        onUnknownRoute: (settings){
          return MaterialPageRoute(builder: (context) => const NotFound());
        },
      )
        );
  }
}