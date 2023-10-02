import 'package:travel_app/models/activity_model.dart';

class City{
  String id;
  String name;
  String image;
  List<Activity> activities;

  City({required this.id, required this.name, required this.image, required this.activities});

  City.fromJSON(Map<String,dynamic> json) :
        id = json["_id"],
        name = json["name"],
        image = json["image"],
        activities = (json["activities"] as List).map((activity) => Activity.fromJSON(activity)).toList();
}