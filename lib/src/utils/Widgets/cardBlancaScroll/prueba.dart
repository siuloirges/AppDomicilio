import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:traelo_app/src/pages/vistasAdministrador/InicioAdministrador/inicioAdministrador.dart';
import 'package:traelo_app/src/utils/Global.dart';

class PruebaWidget extends StatelessWidget {
  final double alto;
  final String t1;
  final String t2;
  final String t3;
  final bool anchoPequenno;
  final Column datos;
  final bool pagConsultar;
  final bool pagActualizar;
  const PruebaWidget({
    Key key,
    this.alto,
    this.datos,
    this.anchoPequenno = false,
    this.t1,
    this.t2,
    this.t3,
    this.pagConsultar = false,
    this.pagActualizar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Container(
      width: anchoPequenno == false ? size.width : size.width * 0.9,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: size.width > 700 ? 21 : size.width * 0.03,
                // color: Colors.grey,
              ),
              Container(
                width: size.width,
                height: size.width > 700 ? 84 : size.width * 0.12,
                color: Colors.transparent,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  elevation: 3,
                  margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Stack(
                    children: [
                      anchoPequenno == true
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    color: amarillo,
                                    width: size.width > 700
                                        ? 7
                                        : size.width * 0.01),
                                Container(
                                    color: amarillo,
                                    width: size.width > 700
                                        ? 7
                                        : size.width * 0.01)
                              ],
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          item(context: context, t1: t1, t2: t2, t3: t3),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.width > 700
                        ? 700 * alto
                        : size.width * alto ?? 1.2,
                    // color: Colors.white,
                    child: Card(
                      margin: const EdgeInsets.only(left: 0, right: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              color: amarillo,
                              width: size.width > 700 ? 7 : size.width * 0.01),
                          Container(
                              color: amarillo,
                              width: size.width > 700 ? 7 : size.width * 0.01)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.width > 700
                        ? 700 * alto
                        : size.width * alto ?? 1.2,
                    child: SingleChildScrollView(child: datos),
                  ),
                ],
              ),
            ],
          ),

          pagConsultar == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width > 700 ? 280 : size.width * 0.4,
                      height: size.width > 700 ? 56 : size.width * 0.08,
                      child: Card(
                        color: verde,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                size.width > 700 ? 10.5 : size.width * 0.015)),
                        margin: const EdgeInsets.all(0),
                        child: Center(
                            child: Text(
                          'Resultados De La Busqueda',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  size.width > 700 ? 21 : size.width * 0.03,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ],
                )
              : pagActualizar == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                                height:
                                    size.width > 700 ? 56 : size.width * 0.08,
                                width:
                                    size.width > 525 ? 262.5 : size.width * 0.5,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: size.width > 389
                                                  ? 16.45
                                                  : size.width * 0.05),
                                          Text(
                                            'ACTUALIZAR DATOS',
                                            style: TextStyle(
                                                fontSize: size.width > 525
                                                    ? 15.75
                                                    : size.width * 0.03,
                                                color: verde,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  elevation: 3,
                                )),
                            Row(
                              children: [
                                SizedBox(
                                    width: size.width > 525
                                        ? 210
                                        : size.width * 0.4),
                                Container(
                                    height: size.width > 700
                                        ? 56
                                        : size.width * 0.08,
                                    width: size.width > 525
                                        ? 57.75
                                        : size.width * 0.11,
                                    child: Card(
                                      child: Image(
                                        image:
                                            AssetImage('assets/actualizar.png'),
                                      ),
                                      elevation: 4,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //         width: size.width * 0.5,
          //         height: size.height * 0.055,
          //         child: Card(
          //           color: verde,
          //           child: Center(
          //             child: Text(
          //               'RESULTADO DE LA BUSQUEDA',
          //               // textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: size.width * 0.032,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget item({BuildContext context, String t1, String t2, String t3}) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Container(
      height: size.width > 700 ? 84 : size.width * 0.12,

      // color: Colors.grey,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(width: size.width*0.02),
                  Container(
                      width: size.width * 0.24,
                      // color: rojo,
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            t1 ?? 'ORDENES',
                            style: TextStyle(
                                fontSize:
                                    size.width > 700 ? 21 : size.width * 0.03,
                                color: Color.fromRGBO(149, 151, 158, 1),
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            height: size.width > 700 ? 14 : size.width * 0.02,
                          )
                        ],
                      ))),
                  Container(
                      width: size.width * 0.24,
                      // color: rojo,
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            t3 ?? 'ESTATUS',
                            style: TextStyle(
                                fontSize:
                                    size.width > 700 ? 21 : size.width * 0.03,
                                color: Color.fromRGBO(149, 151, 158, 1),
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            height: size.width > 700 ? 14 : size.width * 0.02,
                          )
                        ],
                      ))),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        t2 ?? 'REPARTIDOR',
                        style: TextStyle(
                            fontSize: size.width > 700 ? 21 : size.width * 0.03,
                            color: Color.fromRGBO(149, 151, 158, 1),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: size.width > 700 ? 14 : size.width * 0.02,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String texto1;
  final String texto2;
  final String texto3;
  final Color colorT1;
  final Color colorT2;
  final Color colorT3;
  const Item(
      {Key key,
      this.texto1,
      this.texto2,
      this.texto3,
      this.colorT1,
      this.colorT2,
      this.colorT3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Container(
      height: size.width > 700 ? 84 : size.width * 0.12,
      // color: Colors.grey,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(width: size.width*0.02),
                  Container(
                      width: size.width * 0.185,

                      // color: rojo,
                      child: Center(
                          child: Text(
                        texto1 ?? '',
                        style: TextStyle(
                          color: colorT1 ?? Colors.black,
                          fontSize: size.width > 700 && texto1.length > 17
                              ? 14
                              : size.width > 700 && texto1.length > 14
                                  ? 17.5
                                  : size.width > 700 && texto1.length < 13
                                      ? 21
                                      : texto1.length > 17
                                          ? size.width * 0.02
                                          : texto1.length > 14
                                              ? size.width * 0.025
                                              : size.width * 0.03,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ))),
                  Container(
                      width: size.width * 0.185,
                      // color: rojo,
                      child: Center(
                          child: Text(
                        texto3 ?? '',
                        style: TextStyle(
                          color: colorT3 ?? Colors.black,
                          fontSize: size.width > 700 && texto3.length > 17
                              ? 14
                              : size.width > 700 && texto3.length > 14
                                  ? 17.5
                                  : size.width > 700 && texto3.length < 13
                                      ? 21
                                      : texto3.length > 17
                                          ? size.width * 0.02
                                          : texto3.length > 14
                                              ? size.width * 0.025
                                              : size.width * 0.03,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ))),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    texto2 ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorT2 ?? Colors.black,
                      fontSize: size.width > 700 && texto2.length > 17
                          ? 14
                          : size.width > 700 && texto2.length > 14
                              ? 17.5
                              : size.width > 700 && texto2.length < 13
                                  ? 21
                                  : texto2.length > 17
                                      ? size.width * 0.02
                                      : texto2.length > 14
                                          ? size.width * 0.025
                                          : size.width * 0.03,
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: size.width > 700 ? 8.4 : size.width * 0.012,
                    backgroundColor: verde,
                  ),
                  CircleAvatar(
                    radius: size.width > 700 ? 8.4 : size.width * 0.012,
                    backgroundColor: verde,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
