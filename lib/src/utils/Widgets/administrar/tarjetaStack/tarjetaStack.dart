import 'package:flutter/material.dart';

import '../../../Global.dart';

class TarjetaStack extends StatelessWidget {
  final Color colorAccion;
  final Color colorTextoAccion;
  final String texoAccion;
  final Color colorIconoAccion;
  final String ruta;
  final String image;
  const TarjetaStack(
      {Key key,
      this.colorAccion,
      this.colorTextoAccion,
      this.texoAccion,
      this.colorIconoAccion,
      this.ruta,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Container(
          width: _size.width>447?178.8: _size.width * 0.4,
          height:   _size.width>447? 117.1:  _size.width * 0.25,
          // color: Colors.black,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _size.width>439?109.75:   _size.width * 0.25,
                    height:  _size.width>439?81.215:   _size.width * 0.185,
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              color: colorIconoAccion ?? verde,
                              width:
                                  _size.width > 439 ? 43.9 : _size.width * .1,
                              image: AssetImage(
                                image ?? 'assets/notification.png',
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ruta);
                        },
                        child: Container(
                          width: _size.width>447? 156.45 : _size.width * 0.35,
                          height:_size.width>447? 44.7: _size.width*0.1,
                          child: Card(
                              elevation: 3,
                              shadowColor: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    texoAccion ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:_size.width>447? 13.41: _size.width * 0.03,
                                        color: colorTextoAccion ?? verde,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(25))),
                              color: colorAccion ?? amarillo),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
