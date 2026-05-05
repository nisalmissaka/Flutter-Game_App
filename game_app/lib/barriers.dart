import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;
  final bool isTop;

  MyBarrier({required this.size,this.isTop = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 8,color:Colors.green[800]!,),
        borderRadius: BorderRadius.circular(15)
    ),
    );
  }
}