import 'package:flutter/material.dart';

import '../../Global.dart';
// import '../elevacion_container.dart';

class CardOrdenCancelada extends StatelessWidget {
  final String precio;
  final String titulo;
  final String subtitulo;
  final String motivo;

  const CardOrdenCancelada(
      {Key key, this.precio, this.titulo, this.subtitulo, this.motivo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientacion = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        width: orientacion == Orientation.portrait ? size.width : size.width,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width < 322
                        ? size.width * 0.4
                        : size.width < 570
                            ? size.width * 0.6
                            : size.width * 0.7,
                    //color: Colors.grey,
                    child: Text(
                      titulo,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width < 436
                            ? 13.08
                            : size.width > 540
                                ? 16.2
                                : size.width * 0.03,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width < 322
                        ? size.width * 0.4
                        : size.width < 570
                            ? size.width * 0.6
                            : size.width * 0.7,
                    child: Text(subtitulo,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width < 436
                                ? 12.2
                                : size.width > 540
                                    ? 15.12
                                    : size.width * 0.028,
                            color: Color.fromRGBO(103, 96, 95, 1))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Motivo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width > 387
                            ? 11.16
                            : size.width < 331
                                ? 9.93
                                : size.width * 0.03,
                        color: Color.fromRGBO(155, 155, 155, 1)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: size.width < 254
                        ? size.width * 0.2
                        : size.width < 570
                            ? size.width * 0.2
                            : 120,
                    // color: Colors.grey,
                    child: Text(motivo ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width > 387
                                ? 11.16
                                : size.width < 331
                                    ? 9.93
                                    : size.width * 0.03,
                            color: rojo)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width:
                orientacion == Orientation.portrait ? size.width : size.width,
            height: 35,
            color: Color.fromRGBO(251, 251, 251, 1),
            child: Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.9,
                          // color: Colors.grey,
                          child: Text(
                            '\$ ' + precio,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width < 436
                                    ? 15.26
                                    : size.width > 650
                                        ? 22.75
                                        : size.width * 0.035,
                                color: Color.fromRGBO(181, 225, 177, 1)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    ]);
  }
}
