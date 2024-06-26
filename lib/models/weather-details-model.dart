class Coord {
  final double lon;
  final double lat;

  const Coord({required this.lon, required this.lat});
}

class Wheater {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Wheater(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});
}

class Main {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final double pressure;
  final double humidity;

  const Main(
      {required this.temp,
      required this.feels_like,
      required this.temp_min,
      required this.temp_max,
      required this.pressure,
      required this.humidity});
}

class Wind {
  final double speed;
  final double deg;

  const Wind({required this.speed, required this.deg});
}

class Clouds {
  final int all;

  const Clouds({required this.all});
}

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  const Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});
}

class WeatherDetails {
  final Coord coord;
  final List<Wheater> weatherList;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const WeatherDetails({
    required this.coord,
    required this.weatherList,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      coord: Coord(
        lat: (json['coord'] as Map<String, dynamic>)['lat'].toDouble(),
        lon: (json['coord'] as Map<String, dynamic>)['lon'].toDouble(),
      ),
      weatherList: (json['weather'] as List<dynamic>)
          .map((e) => Wheater(
                id: e['id'],
                main: e['main'],
                description: e['description'],
                icon: e['icon'],
              ))
          .toList(),
      base: json['base'],
      main: Main(
        temp: (json['main'] as Map<String, dynamic>)['temp'].toDouble(),
        feels_like:
            (json['main'] as Map<String, dynamic>)['feels_like'].toDouble(),
        temp_min: (json['main'] as Map<String, dynamic>)['temp_min'].toDouble(),
        temp_max: (json['main'] as Map<String, dynamic>)['temp_max'].toDouble(),
        pressure: (json['main'] as Map<String, dynamic>)['pressure'].toDouble(),
        humidity: (json['main'] as Map<String, dynamic>)['humidity'].toDouble(),
      ),
      visibility: json['visibility'].toDouble(),
      wind: Wind(
        speed: (json['wind'] as Map<String, dynamic>)['speed'],
        deg: (json['wind'] as Map<String, dynamic>)['deg'],
      ),
      clouds: Clouds(
        all: (json['clouds'] as Map<String, dynamic>)['all'],
      ),
      dt: json['dt'].toDouble(),
      sys: Sys(
        type: (json['sys'] as Map<String, dynamic>)['type'],
        id: (json['sys'] as Map<String, dynamic>)['id'].toDouble(),
        country: (json['sys'] as Map<String, dynamic>)['country'],
        sunrise: (json['sys'] as Map<String, dynamic>)['sunrise'].toDouble(),
        sunset: (json['sys'] as Map<String, dynamic>)['sunset'].toDouble(),
      ),
      timezone: json['timezone'].toDouble(),
      id: json['id'].toDouble(),
      name: json['name'],
      cod: json['cod'],
    );
  }
}
