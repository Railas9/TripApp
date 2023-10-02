import 'package:flutter/material.dart';

import '../views/home/home_view.dart';
import '../views/trips/trips_view.dart';

class TripAppDrawer extends StatelessWidget {
  const TripAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Text(
              'Trip App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushNamed(context, HomeView.tag);
              }),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('Mes voyages'),
            onTap: () {
              Navigator.pushNamed(context, TripsView.tag);
            },
          )
        ],
      ),
    );
  }
}
