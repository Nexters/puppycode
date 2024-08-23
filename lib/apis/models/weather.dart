// ignore_for_file: constant_identifier_names
enum WeatherType {
  THUNDERSTORM,
  DRIZZLE,
  RAIN,
  SNOW,
  MIST,
  SMOKE,
  HAZE,
  DUST,
  FOG,
  SAND,
  ASH,
  SQUALL,
  TORNADO,
  CLEAR,
  CLOUDS
}

class Weather {
  Weather(dynamic weatherItem) {
    temp = weatherItem['temp'];
    weather = weatherItem['weather'];
    message = weatherItem['weatherMessage'];
  }

  late int temp;
  late String weather;
  late String message;
}
