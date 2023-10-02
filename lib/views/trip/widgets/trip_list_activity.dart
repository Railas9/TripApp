import 'package:flutter/material.dart';
import 'package:travel_app/views/trip/widgets/list_activity.dart';
import '../../../models/activity_model.dart';

class TripListActivity extends StatelessWidget {
  final String? tripId;
  const TripListActivity({Key? key, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("ACTIVITY TRIP LIST");
    return
      DefaultTabController(length: 2,
          child:
             Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    child:const TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(
                            text: "En cours",
                          ),
                          Tab(
                            text: "Passé",
                          )
                        ]
                    ) ,
                  ),
                  SizedBox(
                    height: 600,
                    child: TabBarView(
                      children: [
                        ListActivity(tripId: tripId, filter: ActivityStatus.ongoing),
                        ListActivity(tripId: tripId, filter: ActivityStatus.done)
                      ],
                    ),
                  )
              ]
          )
    );

  }
}
