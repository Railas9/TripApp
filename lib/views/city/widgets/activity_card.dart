import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback selectActivities;
  final bool isSelected;

  const ActivityCard({Key? key, required this.activity, required this.selectActivities, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: double.infinity,
        child:
          Stack(
            fit: StackFit.expand,
            children: [
             Ink.image(
               image: NetworkImage(activity.image!),
               fit: BoxFit.cover,
               child: InkWell(onTap: selectActivities)
             ),
              Padding(padding: const EdgeInsets.all(10),
                child: Column(
                children: [
                  Expanded(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(isSelected)
                        const Icon(Icons.check, color: Colors.white, size: 30)
                    ],
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(activity.name!, style: const TextStyle(color: Colors.white),)
                    ],
                  )
                ],
              ),)
            ],
          )
    );
  }
}
