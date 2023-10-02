import 'package:travel_app/models/activity_model.dart';

class Trip {
  String? id;
  List<Activity> activities;
  String? city;
  DateTime? date;


  Trip({required this.activities,
        required this.city,
        required this.date,
        this.id});

  Trip.fromJSON(Map<String,dynamic> json) :
      id = json["_id"].toString(),
      activities = (json["activities"] as List).map((activity) => Activity.fromJSON(activity)).toList(),
      date = DateTime.parse(json["date"]),
      city = json["city"];

  Map<String,dynamic> toJSON(){
    if(id != null){
      return {
        //if we send null, backend also send null
        '_id': id,
        'date': date!.toIso8601String(),
        'city': city,
        'activities': activities.map((activity) => activity.toJSON()).toList()
      };
    }else{
      return {
        'date': date!.toIso8601String(),
        'city': city,
        'activities': activities.map((activity) => activity.toJSON()).toList()
      };
    }
  }

  @override
  String toString() {
    return 'Trip{city: $city, date: $date, id: $id}';
  }

}