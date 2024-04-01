import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  print("Hello");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _requestPermission(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) => WeatherBloc()
                ..add(FetchWeather(position: snapshot.data as Position)),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const HomeScreen(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color:Colors.lightBlue),
            );
          }
        });
  }
}

Future<Position> _requestPermission() async {
  bool isServiceEnabled;
  LocationPermission permission;
  isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) {
    return Future.error("Permission denied");
  }
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Permission denied");
    }
  }
  return Geolocator.getCurrentPosition();
}
