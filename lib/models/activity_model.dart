enum ActivityStatus { ongoing, done }

class Activity {
  String name;
  String? image;
  String? id;
  String city;
  double? price;
  ActivityStatus status;

  Activity(
      { required this.name,
        required this.city,
         this.id,
         this.image,
         this.price}) : status = ActivityStatus.ongoing;


  // constructeur nomée
  Activity.fromJSON(Map<String, dynamic> json) :
        name = json["name"],
        image = json["image"],
        id = json["_id"],
        price = json["price"].toDouble(),
        city = json["city"],
        status = json["status"] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;

  Map<String,dynamic> toJSON(){
    if(id != null){
      return {
        '_id': id,
        'image': image,
        'city': city,
        'price': price,
        'status': status == ActivityStatus.ongoing ? 0 : 1,
        'name': name
      };
    }else{
      return {
        'image': image,
        'city': city,
        'price': price,
        'status': status == ActivityStatus.ongoing ? 0 : 1,
        'name': name
      };
    }

  }

}