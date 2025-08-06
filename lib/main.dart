// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather/auth/auth_services.dart';
import 'auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'main.dart';


import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class ThemeProvider with ChangeNotifier {
  bool isDark = false;
  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
            home: AuthService().isLoggedIn ? HomeScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
