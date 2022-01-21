import 'dart:ui';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

class SolicitudDeDineroWallet extends StatelessWidget {
//  num buscar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          'Wallet - Solicitud de Dinero',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _barraVerde(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _drowDow(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _cajaDeTexto(),
            ),
            botones(context),
            _movimientos(context),
          ],
        ),
      ),
    );
  }

  Widget _barraVerde(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          width: size.width,
          color: verde,
          child: Center(
              child: Text(
            'Información del Mandado',
            style: TextStyle(fontSize: 13, color: Colors.white),
          )),
        )
      ],
    );
  }

  Widget _drowDow() {
    return DropDownFormField(
      titleText: 'Numero de Orden',
      hintText: 'Escoja su de Orden',
      dataSource: [],
      // valueField: ,
    );
  }

  Widget _cajaDeTexto() {
    return Column(
      children: [
        Row(
          children: [Text('Monto a Solicitar')],
        ),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
              hintText: '\$ 0',
              hintStyle: TextStyle(fontWeight: FontWeight.bold)
              // helperMaxLines: 5

              ),
        ),
      ],
    );
  }

  Widget botones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: size.width < 212
              ? const EdgeInsets.all(3)
              : const EdgeInsets.all(8.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: rojo,
            child: Text(
              'Cancelar',
              style: TextStyle(color: blanco),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: size.width < 212
              ? const EdgeInsets.all(3)
              : const EdgeInsets.all(8.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: amarillo,
            child: Text(
              'Solicitar',
              style: TextStyle(color: verde),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Column(
                        children: [
                          Image(
                              image: AssetImage('assets/tick.png'),
                              width: 30),
                          Text(
                            'SU SOLICITUD HA SIDO',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'EXITOSA',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              shape: StadiumBorder(),
                              color: verde,
                              child: Text(
                                'Listo',
                                style: TextStyle(
                                    color: blanco,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget _movimientos(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      //  height: _size.height * .3,
      width: _size.width * .99,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: _size.height / 2,
                  width: _size.width / 1.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: _size.width / 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: _size.height,
                                  color: amarillo,
                                  // height: ma,
                                  width: 2,
                                )
                              ],
                            ),
                            SingleChildScrollView(child: item(context)),
                            Column(
                              children: [
                                Container(
                                  color: Color.fromRGBO(248, 248, 248, 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        // color:amarillo,
                                        height: _size.width / 9,
                                        width: _size.width / 1.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Fecha',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey)),
                                            Text('Accion',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),

          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //        crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(7),
          //           child: Container(
          //             width:
          //             _orientacion == Orientation.portrait?
          //             _size.width * 0.80: _size.width * 0.41,
          //             height:
          //             _orientacion == Orientation.portrait?
          //             _size.width * 0.15:_size.width * 0.08,
          //             child: Card(
          //               elevation: 3,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(5)),
          //               color: amarillo,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          //      Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [

          //         Card(
          //           elevation: 5,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10000)),
          //           child: CircleAvatar(
          //             backgroundImage: AssetImage('assets/wallet.png'),
          //             backgroundColor: Colors.white,
          //             //  child: Image(image: ,),
          //             radius: 35,
          //           ),
          //         ),
          //         SizedBox(
          //           width: _size.width / 10,
          //         ),
          //         Text(
          //           'Movimientos',
          //           style: TextStyle(
          //               fontSize: 25,
          //               color: verde,
          //               fontWeight: FontWeight.w600),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget item(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Column(children: [
          SizedBox(
            height: _size.height / 15,
          ),
          datos(context),
          datos(context),
          datos(context),
          datos(context),
          datos(context),
          datos(context),
          datos(context),
          datos(context),
        ]),
      ],
    );
  }

  Widget datos(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Text('08/26'),
                      Text(''),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$ 50,000',
                        style: TextStyle(
                            color: verde, fontWeight: FontWeight.bold),
                      ),
                      Text('Trasferencia'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _size.height / 30,
            )
          ],
        ),
        indicador(context)
      ],
    );
  }

  Widget indicador(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: verde,
              radius: 5,
              // width: 300,
              // height: 10,
            ),
          ],
        ),
        SizedBox(
          height: _size.height / 15,
        )
      ],
    );
  }
}
