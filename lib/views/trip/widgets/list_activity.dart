import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/trip_provider.dart';

import '../../../models/activity_model.dart';
import '../../../models/trip_model.dart';

class ListActivity extends StatelessWidget {
  final String? tripId;
  final ActivityStatus filter;

  const ListActivity({Key? key, required this.tripId, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //print("ACTIVITY LIST");
    final Trip trip = Provider.of<TripProvider>(context).getTrip(tripId!);
    final List<Activity> activities = trip.activities.where((activity) => activity.status == filter).toList();


    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index){
         return Container(
             margin: const EdgeInsets.all(10),
             child: ActivityStatus.ongoing == filter ? Dismissible(
               direction: DismissDirection.endToStart,
               background: Container(
                 alignment: Alignment.centerRight,
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.center,
                     end: Alignment.centerRight,
                     colors: <Color>[
                       Colors.green.withOpacity(0.01),
                       Colors.green.withOpacity(0.6),
                       Colors.green
                     ], // Gradient from https://learnui.design/tools/gradient-generator.htm
                   ),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: const Icon(Icons.check, color: Colors.white,),
               ),
                key: ValueKey(activities[index].id),
                child: Card(
                child:
                ListTile(
                title: Text(activities[index].name!),
                )
          ),
               confirmDismiss: (_){
                return Provider.of<TripProvider>(context, listen: false).updateTrip(trip, activities[index].id!)
                    .then((_) => true)
                    .catchError((_)=>false);
               },

          ) : Card(
                 child:
                 ListTile(
                   title: Text(activities[index].name!, style: const TextStyle(color: Colors.grey),),
                 )
             )
         );
         });

  }
}
