import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/activity_model.dart';
import '../models/trip_model.dart';

class TripProvider with ChangeNotifier{
  late List<Trip> _trips = [];
  //final host = 'localhost';
  final host = '192.168.1.8:80';
  bool isLoading = false;
  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  addTrip(Trip trip) async{try{
      http.Response response = await http.post(Uri.http(host, '/api/trip'), body: jsonEncode(trip.toJSON()) , headers: {
        'Content-type': 'application/json'
      });
      if(response.statusCode ==200){
        isLoading = false;
        _trips.add(Trip.fromJSON(jsonDecode(response.body)));
        notifyListeners();
      }
    }catch(e){
      rethrow;
    }
  }

  getTrip(String tripId){
    return _trips.firstWhere((trip) => trip.id == tripId);
  }

  Future<void> updateTrip(Trip trip, String activityId) async{
    //optimistic update
    Activity activity = trip.activities.firstWhere((activity) => activity.id == activityId);
    activity.status = ActivityStatus.done;
    try{
      http.Response response = await http.put(Uri.http(host, '/api/trip'),
          body: jsonEncode(trip.toJSON()),
          headers: {
            'Content-type': 'application/json'
          });
      if(response.statusCode != 200){
        activity.status = ActivityStatus.ongoing;
        throw const HttpException("error");
      }
      notifyListeners();
    }catch(e){
      rethrow;
    }

  }

  Future<void> fetchTrips() async {
    isLoading = true;
    try{
      http.Response response = await http.get(Uri.http(host, '/api/trips'));
      if(response.statusCode ==200){
        _trips = (jsonDecode(response.body) as List).map((trip) => Trip.fromJSON(trip)).toList();
        isLoading = false;
        notifyListeners();
      }
    }catch(e){
      isLoading = false;
      rethrow;
    }

  }

}