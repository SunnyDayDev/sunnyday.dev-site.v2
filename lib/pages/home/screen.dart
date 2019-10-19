
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  
  AnimationController _logoAnimationController;
  
  @override
  void initState() {
    _logoAnimationController =  AnimationController(duration: Duration(seconds: 3), vsync: this);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    _logoAnimationController.reset();
    _logoAnimationController.repeat();
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Center(
            child: _animatedLogo,
          )
        ],
      ),
    );
  }
  
  Widget get _animatedLogo => AnimatedBuilder(
    animation: Tween(begin: 0.0, end: 1.0).animate(_logoAnimationController),
    builder: (context, child) => Transform(
      transform: Matrix4.rotationY(_logoAnimationController.value * pi),
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        child: Image.asset("assets/images/logo.png"),
      ),
    ),
  );
  
  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }
  
}