import 'package:flutter/material.dart';
import 'package:weather/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with SingleTickerProviderStateMixin {
  final _cityController = TextEditingController();
  String? _weather;
  bool _loading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _fetchWeather() async {
    if (_cityController.text.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _weather = null;
    });
    final data = await WeatherService.fetchWeather(_cityController.text.trim());
    setState(() {
      _weather = data;
      _loading = false;
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.lightBlue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          children: [
            Text(
              "Check the weather anywhere",
              style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _cityController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter city name",
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.location_city, color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _fetchWeather,
                icon: Icon(Icons.cloud, size: 24),
                label: Text("Get Weather", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (_loading)
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            if (_weather != null && !_loading)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  color: Colors.white.withOpacity(0.85),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      _weather!,
                      style: theme.textTheme.headlineSmall?.copyWith(color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
