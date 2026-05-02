import 'package:flutter/material.dart';
import 'package:game_app/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double birdYaxis = 0;

  void jump() {
    setState(() {
      birdYaxis -= 0.1;

      // limit top movement
      if (birdYaxis < -1) {
        birdYaxis = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: jump,
              child: AnimatedContainer(
                alignment: Alignment(0, birdYaxis),
                duration: const Duration(milliseconds: 200), 
                curve: Curves.easeOut, // smooth animation
                color: Colors.blue,
                child: MyBird(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}