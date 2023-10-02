import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/trip_provider.dart';
import 'package:travel_app/views/trips/widgets/tips_list.dart';
import 'package:travel_app/widgets/trip_app_drawer.dart';
import 'package:travel_app/widgets/trip_loader.dart';

import '../../models/trip_model.dart';



class TripsView extends StatelessWidget {

  static const String tag = '/trips';

  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {

    final TripProvider tripProvider = Provider.of<TripProvider>(context);

    return
      DefaultTabController(
          length: 2,
          child:
        Scaffold(
        appBar: AppBar(
          title: const Text('Mes voyages'),
          bottom: const TabBar(
            tabs: [
              Tab(
              text: "à venir",
            ),
              Tab(
                text: "Passé",
              )
            ]
          ),
        ),
        drawer: const TripAppDrawer(),
        body:
        !tripProvider.isLoading ?
        tripProvider.trips.isNotEmpty ? TabBarView(
          children : [

              TripList(trips:  tripProvider.trips.where((element) => DateTime.now().isBefore(element.date!)).toList(),),

              TripList(trips:  tripProvider.trips.where((element) => DateTime.now().isAfter(element.date!)).toList(),),

          ]
        ) : Container(alignment: Alignment.center, child: const Text('Aucun voyage pour le moment')
          ,) : const TripLoader()
        )
      );

  }
}