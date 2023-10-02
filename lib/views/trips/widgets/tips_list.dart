import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/views/trip/trip_view.dart';

import '../../../models/trip_model.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  const TripList({Key? key, required this.trips}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      return ListTile(
        title: Text(trips[index].city!),
        subtitle: trips[index].date != null ? Text( DateFormat("d/M/y").format(trips[index].date!)) : null,
        onTap: (){
          Navigator.pushNamed(context, TripView.tag, arguments: {"tripId": trips[index].id, "cityName": trips[index].city});
        },
      );
    },
    itemCount: trips.length,);
  }
}
