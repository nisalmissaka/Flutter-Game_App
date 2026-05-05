import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_app/barriers.dart';
import 'package:game_app/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
        
       
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        }
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        }
      });

      if (birdYaxis > 1.1) {
        timer.cancel();
        _resetGame();
      }
    });
  }

  void _resetGame() {
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.5; // Reset positions
      barrierXtwo = barrierXone + 1.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (gameHasStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: Stack(
                  children: [
                    // Bird
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: Transform.rotate(
                        angle: 3.14,
                        child: MyBarrier(size: screenHeight * 0.2),
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(size: screenHeight * 0.2),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: Transform.rotate(
                        angle: 3.14,
                        child: MyBarrier(size: screenHeight * 0.15),
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(size: screenHeight * 0.25),
                    ),

                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text("")
                          : const Text(
                              "T A P  T O  P L A Y",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 10, color: Colors.green),
            Container(
              height: 80,
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("SCORE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text("0", style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("BEST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text("10", style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}