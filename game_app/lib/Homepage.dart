import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_app/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 static double birdYaxis = -1;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;

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
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
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
            child:Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    if (gameHasStarted){
                      jump();
                    }else{
                      startGame();
                    }
                    
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0,birdYaxis),
                    duration: Duration(microseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                ),
                Container(
                  alignment: Alignment(0,-0.3),
                  child: Text("T A P  T O  P L A Y",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                    ),),
                )
              ],
            )
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SCORE", style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(height: 20,),
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 35)),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BEST", style: TextStyle(color: Colors.white,fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text("10",style: TextStyle(color: Colors.white,fontSize: 35)),
                  ],
                )
              ],),
            ),
          ),
        ],
      ),
    );
  }
}