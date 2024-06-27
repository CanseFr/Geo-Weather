class TraductionWeather {
  static String traductWeather(String weather){
    switch (weather.toLowerCase()) {
      case 'clear sky':
        return 'Ciel dégagé';
      case 'few clouds':
        return 'Quelques nuages';
      case 'scattered clouds':
        return 'Nuages épars';
      case 'broken clouds':
        return 'Nuages brisés';
      case 'shower rain':
        return 'Averses de pluie';
      case 'rain':
        return 'Pluie';
      case 'thunderstorm':
        return 'Orages';
      case 'snow':
        return 'Neige';
      case 'mist':
        return 'Brume';
      default:
        return weather;
    }
  }

  static String kelvinToCelsius(double kelvinValue) {
    double celsiusValue = kelvinValue - 273.15;
    return celsiusValue.toStringAsFixed(2);
  }

}