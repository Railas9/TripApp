import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/trip_provider.dart';
import 'package:travel_app/views/activity_form/activity_form_view.dart';
import 'package:travel_app/views/city/widgets/activity_grid.dart';
import 'package:travel_app/views/city/widgets/my_activities.dart';
import 'package:travel_app/views/city/widgets/trip_overview.dart';
import '../../models/activity_model.dart';
import '../../models/city_model.dart';
import '../../models/trip_model.dart';
import '../../providers/city_provider.dart';
import '../home/home_view.dart';

class CityView extends StatefulWidget {
  static const tag = "/city";

  const CityView({super.key});


  @override
  CityState createState() => CityState();

  Widget showContext({ required BuildContext context, required List<Widget> children}){
    var orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.landscape){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,);
    }else{
      return Column( children: children,);
    }
  }



}

class CityState extends State<CityView> {
  late Trip myTrip;
  late int index;

  @override
  void initState() {
    super.initState();
    myTrip = Trip(activities: [], city: null, date: null);
    index = 0;
  }


  void setDate() {
   showDatePicker(context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025)
    ).then((value){
      if(value != null){
        setState(() {
          myTrip.date = value;
        });
      }
   });
  }

  void changeIndex(int value){
    setState(() {
      index = value;
    });
  }

  void selectActivities(Activity activity){
    setState(() {
      myTrip.activities.contains(activity) ?  myTrip.activities.remove(activity) : myTrip.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      myTrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Voulez-vous sauvegarder ?'),
        contentPadding: const EdgeInsets.all(20),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).disabledColor),
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.pop(context, 'cancel');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pop(context, 'save');
                },
                child: const Text(
                  'Sauvegarder',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
    if(myTrip.date == null){
      if(mounted) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Attention !'),
            content: const Text('Vous n avez pas entré de date'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
      }
    } else if (mounted && result == "save"){
      myTrip.city = cityName;
      Provider.of<TripProvider>(context, listen: false).addTrip(myTrip);
      Navigator.pushNamed(context, HomeView.tag);
    }
    // utilisation de ModalRoute.of(context)!.settings.arguments pour recup argument qui est 3eme param de pushNamed

  }



  double get amount{
   return myTrip.activities.fold(0.00, (previousValue, element){
      return previousValue + element.price!;
    });
  }


  @override
  Widget build(BuildContext context) {
    final String cityName = ModalRoute.of(context)?.settings.arguments as String;
    final City city = Provider.of<CityProvider>(context).getCityByName(cityName);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){Navigator.pushNamed(context, ActivityFormView.tag, arguments: cityName);}, icon: Icon(Icons.add))
          ],
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: const Text("Organisation du voyage"),
        ),
        body:
        widget.showContext(context: context, children: [

            TripOverview(cityName: city.name ,myTrip: myTrip, setDate: setDate, amount: amount, cityImage: city.image),

            index == 0 ?

            ActivityGrid(
                activities: city.activities,
                selectedActivities : myTrip.activities,
                selectActivities: selectActivities,
            )
                :

            MyActivities(myActivities: myTrip.activities, deleteActivity: deleteTripActivity,)

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Découvertes"),
            BottomNavigationBarItem(icon: Icon(Icons.stars), label: "Mes activités")
          ],
          onTap: changeIndex,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            saveTrip(cityName);
          },
          child: const Icon(Icons.forward),
        ),
      );
  }
}
