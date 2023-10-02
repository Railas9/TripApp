import 'package:flutter/material.dart';

class TripLoader extends StatelessWidget {
  const TripLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
