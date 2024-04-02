class MyData {
  List<String> weatherIconsList = [
    'assets/images/thunder.png',
    'assets/images/sunny-and-rainy-day.webp',
    'assets/images/rain.png',
    'assets/images/snow.png',
    'assets/images/atmosphere.png',
    'assets/images/clear.png',
    'assets/images/clouds.png',
  ];
  String weatherIcons(int status) {
    switch (status) {
      case >= 200 && <= 232: // Thunder

        return weatherIconsList[0];

      case >= 300 && <= 321: //Drizzle
        return weatherIconsList[1];

      case >= 500 && <= 531: //Rain
       
        return weatherIconsList[2];

      case >= 600 && <= 622: //Snow
        return weatherIconsList[4];

      case >= 701 && <= 781: // Atmosphere
        return weatherIconsList[5];
      case 800: // clear
        return weatherIconsList[5];
      case >= 801 && <= 804: // Clouds
        return weatherIconsList[5];

      default:
        return '';
    }
  }
}
