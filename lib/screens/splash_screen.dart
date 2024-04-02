import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {});
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MyWeather',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15,),
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/icon.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
              animatedTexts: [
                TyperAnimatedText('Welcome to WeatherApp! '),
                TyperAnimatedText('Your go-to destination for'),
                TyperAnimatedText('Accurate weather forecasts.'),
                TyperAnimatedText('Lets, Continue →'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
