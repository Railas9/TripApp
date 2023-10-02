import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class MyActivities extends StatelessWidget {
  final List<Activity> myActivities;
  final Function(Activity) deleteActivity;
  const MyActivities({Key? key, required this.myActivities, required this.deleteActivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index){
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(myActivities[index].image!)
              ),
              title: Text(myActivities[index].name!),
              subtitle: Text(myActivities[index].city),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: (){
                  deleteActivity(myActivities[index]);

                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                      content: Text('Activitée supprimée'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                      ),
                    );

                },
              ),
            );
          },
          itemCount:  myActivities.length,
          ),
    );
  }
}
