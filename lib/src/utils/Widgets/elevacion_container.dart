import 'package:flutter/material.dart';

class Elevacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientacion = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    return Container(
      width: orientacion == Orientation.portrait ? size.width : size.width,
      height: orientacion == Orientation.portrait
          ? size.height * 0.007
          : size.height * 0.015,
      // decoration: BoxDecoration(
      //   color: Colors.blue,
      // gradient: LinearGradient(
      //   stops: [0.2, 0.5, 0.8],
      // begin: FractionalOffset.topCenter,
      //end: FractionalOffset.bottomCenter,
      //colors: [
      //Color.fromRGBO(240, 240, 240, 1),
      //Color.fromRGBO(245, 245, 245, 1),
      //Color.fromRGBO(250, 250, 250, 1)
      // ])),
    );
  }
}
