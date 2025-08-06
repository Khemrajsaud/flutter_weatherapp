import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/auth/auth_services.dart';
import 'package:weather/auth/login_screen.dart';
import '../main.dart';
import 'camera_screen.dart';
import 'counter_screen.dart';
import 'weather_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WeatherScreen(),
    CameraScreen(),
    CounterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            tooltip: "Toggle Theme",
            onPressed: () => themeProvider.toggleTheme(),
          ),
          


          IconButton(
  icon: Icon(Icons.logout),
  tooltip: "Logout",
  onPressed: () async {
    await AuthService().logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  },
),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: themeProvider.isDark ? Colors.grey[900] : Colors.white,
        indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Counter',
          ),
        ],
      ),
    );
  }
}
