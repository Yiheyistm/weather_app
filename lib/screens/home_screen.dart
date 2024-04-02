import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/my_data.dart';
import 'dart:developer' as devtool show log;

import 'package:weather_app/screens/component/greeting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(alignment: Alignment.topCenter, children: [
            Align(
              alignment: const AlignmentDirectional(15, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.deepPurple, shape: BoxShape.circle),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-15, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.deepPurple, shape: BoxShape.circle),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.9),
              child: Container(
                height: 300,
                width: 600,
                color: Colors.orange,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherSuccess) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text(
                          '📍 ${state.weather.areaName}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        greating(state.weather.date!.hour),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              MyData().weatherIcons(
                                  state.weather.weatherConditionCode!),
                              scale: 6,
                            ),
                            Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('EEEE dd .')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/sun1.png',
                                      scale: 3,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/moon.png',
                                      scale: 4,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Sunset',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Divider()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/maxTemp.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Max',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius!.round()}°C',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/minTemp.png',
                                      scale: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Min',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${state.weather.tempMin!.celsius!.round()}°C',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                  );
                } else {
                  devtool.log(state.toString());
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }
              },

            ),
           
          ]),
        ),
      ),
    );
  }
}
