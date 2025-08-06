import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() => _counter++);
    _animateCounter();
  }

  void _decrement() {
    setState(() => _counter--);
    _animateCounter();
  }

  void _animateCounter() {
    _animationController.forward(from: 0).then((_) => _animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Count',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 12),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  '$_counter',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _increment,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      elevation: 6,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.5),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    child: Icon(Icons.add, size: 28, color: Colors.white),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: _decrement,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      elevation: 6,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.5),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    child: Icon(Icons.remove, size: 28, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
