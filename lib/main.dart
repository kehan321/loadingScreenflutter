import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlinkingImage(),
    );
  }
}

class BlinkingImage extends StatefulWidget {
  @override
  _BlinkingImageState createState() => _BlinkingImageState();
}

class _BlinkingImageState extends State<BlinkingImage> {
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        _isVisible = !_isVisible; // Toggle visibility every 500 milliseconds
      });
      if (timer.tick == 15) { // 10 ticks * 500 milliseconds = 5000 milliseconds = 5 seconds
        _timer.cancel(); // Cancel the timer after 5 seconds
        // Navigate to a new screen after 5 seconds
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NextScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500), // Duration of the animation
          child: Image.asset('assets/your_image.png'), // Replace with your image asset
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is the next screen!'),
      ),
    );
  }
}
