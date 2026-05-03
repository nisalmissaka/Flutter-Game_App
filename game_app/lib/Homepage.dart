import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_app/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = -1;
  double time = 0;
  double height = 0;
  double initialHeight = 0;

  void jump() {
    initialHeight = birdYaxis;
   Timer.periodic(Duration(milliseconds: 100),(timer){
    time += 0.05;
    height = -4.9 * time * time + 5 * time;
    setState(() {
      birdYaxis = initialHeight - height;
    });
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