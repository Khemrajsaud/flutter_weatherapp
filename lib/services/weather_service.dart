import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String _apiKey = '29db157e189be745577c039ac9187697'; // Replace with your OpenWeatherMap API Key

  static Future<String> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['main']['temp'];
        final desc = data['weather'][0]['description'];
        return 'Temperature in $city: $temp°C\nCondition: $desc';
      } else {
        return 'Error: City not found';
      }
    } catch (e) {
      return 'Error fetching weather';
    }
  }
}

