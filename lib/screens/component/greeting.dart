import 'package:flutter/material.dart';

Widget greating(int currentHour) {
  String? greeting;
  if (currentHour >= 5 && currentHour < 12) {
    greeting = "Good Morning,";
  } else if (currentHour >= 12 && currentHour < 17) {
    greeting = "Good Afternoon,";
  } else {
    greeting = "Good Evening,";
  }

  return Text('$greeting Abeto',
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25));
}
