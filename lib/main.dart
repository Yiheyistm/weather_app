import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'dart:developer' as devTool show log;

import 'package:weather_app/screens/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  print({dotenv.env['WEATHER_API-KEY']});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    return FutureBuilder(
        future: _requestPermission(geolocator),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            devTool.log(snapshot.data.toString());
            return BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()
                ..add(FetchWeather(position: snapshot.data as Position)),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: HomeScreen(),
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
            );
          }
        });
  }
}

Future<Position> _requestPermission(GeolocatorPlatform geolocator) async {
  bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) {
    return Future.error(
        "Location services are disabled. Please enable them in your device settings.");
  }

  LocationPermission permission = await geolocator.checkPermission();

  switch (permission) {
    case LocationPermission.whileInUse:
    case LocationPermission.always:
      devTool.log("Finding position...");
      return await geolocator.getCurrentPosition();
    case LocationPermission.denied:
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permission to access location is denied.");
      }

      devTool.log("Finding position...");
      return await geolocator.getCurrentPosition();
    case LocationPermission.deniedForever:
      return Future.error(
          "Location permission is permanently denied. To enable it, go to your device settings and grant location permission to this app.");
    default:
      return Future.error("Unexpected permission status: $permission");
  }
}
