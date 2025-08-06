import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Light"),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themeProvider.isDark ? Colors.black : Colors.yellow,
          ),
          child: Switch(
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
        ),
        Text("Dark")
      ],
    );
  }
}