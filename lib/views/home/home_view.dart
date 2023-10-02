import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/providers/city_provider.dart';
import 'package:travel_app/views/home/widgets/city_card.dart';
import 'package:travel_app/widgets/trip_app_drawer.dart';
import 'package:travel_app/widgets/trip_loader.dart';


class HomeView extends StatefulWidget {

  static const tag = "/";

  const HomeView({super.key});

  /*
  pushModal(context){
    askModal(context, "here is a modal").then((value) => print(value));
  }
*/
  @override
  HomeState createState() => HomeState();

}

class HomeState extends State<HomeView>{
/*
  void updateCard(city){
    setState(() {
      city["checked"] = ! city["checked"];
    });
  }
*/

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<City> cities = Provider.of<CityProvider>(context).getFilteredCities(searchController.text);
    return Scaffold(
      appBar: AppBar(title: const Text("Trip App"),),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            children: [
               Container(
                 margin: const EdgeInsets.only(top: 10),
                 padding: const EdgeInsets.symmetric(horizontal: 10)
              ,
              child: Row(
                children: [
                  Expanded(child:
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Rechercher une ville"
                    ),
                  )),
                  IconButton(onPressed: (){
                    setState(() {
                      searchController.clear();
                    });
                  }, icon: const Icon(Icons.clear))
                ],
              ),),
              Expanded(child:
              RefreshIndicator(
                onRefresh: Provider.of<CityProvider>(context).fetchCities,
                child: cities.isNotEmpty ? ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (_,i) => CityCard(city: cities[i]),
                  /*
              ElevatedButton(onPressed: (){
                widget.pushModal(context);
              }, child: const Text("modal"))
               */
                ) : const TripLoader(),

              ))
]
        )
      ),
      drawer: const TripAppDrawer()
    );
  }
}
