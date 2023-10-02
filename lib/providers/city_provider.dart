import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import '../models/activity_model.dart';
import '../models/city_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CityProvider with ChangeNotifier{
  late List<City> _cities = [];
  //final host = 'localhost';
  final host = '192.168.1.8:80';
  bool isLoading = false;
  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities); // lecture seul

  UnmodifiableListView<City> getFilteredCities(String filter) => UnmodifiableListView(_cities.where((city) => city.name.toLowerCase().startsWith(filter.toLowerCase())).toList());

  getCityByName(String cityName) => _cities.firstWhere((city) => city.name == cityName);

  Future<void> fetchCities() async {
    isLoading = true;
    try{
      http.Response response = await http.get(Uri.http(host, '/api/cities'));
      if(response.statusCode ==200){
        _cities = (jsonDecode(response.body) as List).map((city) => City.fromJSON(city)).toList();
        isLoading = false;
        notifyListeners();
      }
    }catch(e){
      isLoading = false;
      rethrow;
    }
  }

  Future<void> addActivityToCity(Activity newActivity) async{
    try{
      String cityID = getCityByName(newActivity.city).id;
      http.Response response = await http.post(Uri.http(host, '/api/city/$cityID/activity'), body: jsonEncode(newActivity.toJSON()) , headers: {
        'Content-type': 'application/json'
      });
      if(response.statusCode == 200){
        int index = _cities.indexWhere((city) => cityID == city.id);
        _cities[index] = City.fromJSON(jsonDecode(response.body));
        notifyListeners();
      }
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> verifyNameActivity(String cityName, String activityName) async{
    try{
      String cityID = getCityByName(cityName).id;
      http.Response response = await http.get(Uri.http(host, '/api/city/$cityID/activities/verify/$activityName'));
      if(response.statusCode != 200){
        return jsonDecode(response.body);
      }else {
        return null;
      }
    }catch(e){
      rethrow;
    }
  }

  Future<String?> uploadImage(File pickedImage) async {
    try{
      //preparation de la requete
      var request = http.MultipartRequest("POST", Uri.http(host, '/api/activity/image'));
      request.files.add(
        http.MultipartFile.fromBytes(
            "activity",
          pickedImage.readAsBytesSync(),
          filename: basename(pickedImage.path),
          contentType: MediaType("multipart", "form-data")
        )
      );
      var response = await request.send();
      if(response.statusCode == 200){
        var responseData = await response.stream.toBytes();
        return json.decode(String.fromCharCodes(responseData));
      }
    }catch(e){
      rethrow;
    }
  }

}