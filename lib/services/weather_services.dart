import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_application_2/constant/const.dart';
import 'package:weather_application_2/model/weather_model.dart';

class CallToApi {
  Future<WeatherModel> fetchWeather(String cityName) async {
    try {
      var apiUrl = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": apiKey});

      final http.Response response = await http.get(apiUrl);
      log(response.body.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return WeatherModel.fromMap(data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
