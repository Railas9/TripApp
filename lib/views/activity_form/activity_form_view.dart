import 'package:flutter/material.dart';
import 'package:travel_app/views/activity_form/widgets/activity_form.dart';
import 'package:travel_app/widgets/trip_app_drawer.dart';

class ActivityFormView extends StatelessWidget {
  static const tag = "/activity-form";
  const ActivityFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String cityName = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar( title: const Text("Ajout activité")),
      drawer: const TripAppDrawer(),
      body: SingleChildScrollView(child: ActivityForm( cityName: cityName,),),
    );
  }
}
