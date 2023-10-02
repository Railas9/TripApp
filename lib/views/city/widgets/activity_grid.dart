import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';
import 'activity_card.dart';

class ActivityGrid extends StatelessWidget {
  final List<Activity> activities;
  final Function selectActivities;
  final List<Activity> selectedActivities;

  const ActivityGrid({Key? key, required this.activities, required this.selectActivities, required this.selectedActivities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        crossAxisCount: 2,
        children: [...activities.map((activity) => ActivityCard(
          isSelected: selectedActivities.contains(activity),
          activity: activity,
          selectActivities: (){
            selectActivities(activity);
          },)
        )],
      ),
    );
  }
}
