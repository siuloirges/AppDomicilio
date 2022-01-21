import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'models/respWalletRepartidorModel.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  bool contabilidad = false;
  bool peticion =false;
  dynamic globalRespMovimientos=[];
 String vacio;
  Funciones funciones = new Funciones();
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  String debito;
  String credito;

  @override
  Widget build(BuildContext context) {
     
     if (peticion == false) {
       pedir(context);
      globalRespMovimientos = [];
      setState(() {});
      peticion = true;
    }
    // final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: _orientacion == Orientation.portrait
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                saldoDebito(context),

                saldoCredito(context),

                SizedBox(
                  height: 10,
                ),
                // Expanded(child: saldoDebito()),
                Expanded(flex: 8, child: _movimientos(context)),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      saldoDebito(context, valor: debito),
                      saldoCredito(context, valor: credito),
                    ],
                  ),
                ),

                // Expanded(child: saldoDebito()),
                Expanded(flex: 1, child: _movimientos(context)),
              ],
            ),
    );
  }

  Widget saldoDebito(BuildContext context, {String valor}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      // height: 400,
      child: Container(
        // color:Colors.redAccent,
        height: _orientacion == Orientation.portrait
            ? _size.width * 0.3
            : _size.width * 0.14,
        width: _orientacion == Orientation.portrait
            ? _size.width / 1.05
            : _size.width / 2.05,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        width: _orientacion == Orientation.portrait
                            ? _size.width * .755
                            : _size.width * .38,
                        height: _orientacion == Orientation.portrait
                            ? _size.width * .2
                            : _size.width * .1,
                        child: Card(
                          elevation: 3,
                          color: verde,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Center(
                    child: Text(
                  'Saldo Debito',
                  style: TextStyle(color: Colors.grey),
                ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          child: Center(
                              child: Text(
                            'Retirar',
                            style: TextStyle(color: verde),
                          )),
                          width:
                              _orientacion == Orientation.portrait ? 120 : 80,
                          height:
                              _orientacion == Orientation.portrait ? 30 : 25,
                          color: amarillo,
                        ))
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/wallet.png'),
                        backgroundColor: Colors.white,
                        //  child: Image(image: ,),
                        radius: 45,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    contabilidad == false
                        ? CircularProgressIndicator()
                        : Text(
                            '\$ ${valor ?? 0}',
                            style: TextStyle(
                                fontSize: 30,
                                color: blanco,
                                fontWeight: FontWeight.w600),
                          ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget saldoCredito(BuildContext context, {String valor}) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Container(
      height: _orientacion == Orientation.portrait
          ? _size.width * .3
          : _size.width * .2,
      width: _orientacion == Orientation.portrait
          ? _size.width * .95
          : _size.width * .5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      width: _orientacion == Orientation.portrait
                          ? _size.width * 0.80
                          : _size.width * 0.41,
                      height: _orientacion == Orientation.portrait
                          ? _size.width * 0.15
                          : _size.width * 0.08,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: rojo,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: _size.width / 30,
              ),
              Center(
                  child: Text(
                'Saldo Credito',
                style: TextStyle(color: Colors.grey),
              ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  contabilidad == false
                      ? CircularProgressIndicator()
                      : Text(
                          '\$ ${valor ?? 0}',
                          style: TextStyle(
                              fontSize: 30,
                              color: blanco,
                              fontWeight: FontWeight.w600),
                        ),
                  SizedBox(
                    width: _size.width / 10,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10000)),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/wallet.png'),
                      backgroundColor: Colors.white,
                      //  child: Image(image: ,),
                      radius: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              botones(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget botones(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('solicitudDeDineroWallet');
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                child: Center(
                    child: Text(
                  'Solicitud de Dinero',
                  style: TextStyle(color: verde),
                )),
                width: _orientacion == Orientation.portrait
                    ? _size.width / 2
                    : _size.width / 5,
                height: _orientacion == Orientation.portrait
                    ? _size.width / 15
                    : _size.width / 25,
                color: amarillo,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                child: Center(
                    child: Text(
                  'Pagar',
                  style: TextStyle(color: blanco),
                )),
                width: _orientacion == Orientation.portrait
                    ? _size.width / 4
                    : _size.width / 8,
                height: _orientacion == Orientation.portrait
                    ? _size.width / 15
                    : _size.width / 25,
                color: verde,
              )),
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
                            globalRespMovimientos.length == 0
                ? Container()
                : vacio == 'vacio'
                    ? Container
                    :  Row(
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
          Column(
            children: globalRespMovimientos.length == 0
                ? [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        backgroundColor: amarillo,
                        strokeWidth: 1,
                      ),
                    ))
                  ]
                : vacio == "vacio"
                    ? 
                        [datos(context,valor: '123213',fecha: '3123',tipo: '1232'    )]
                      
                    : globalRespMovimientos,
          )
        ]),
      ],
    );
  }

  

  Widget datos(BuildContext context,
      {String fecha, String valor, String tipo}) {
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
                      Text(fecha ?? '08/26'),
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
                        '\$ ${valor ?? 50000}',
                        style: TextStyle(
                            color: verde, fontWeight: FontWeight.bold),
                      ),
                      Text(tipo ?? 'Trasferencia'),
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

  pedir(context) async {
    final size = MediaQuery.of(context).size; //  CircularProgressIndicator();
    try {
      // load(context);

      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'wallets?id_repartidor=${prefs.user_id}',
        token: prefs.token,
      );
      if (resp['message'] == "expiro") {
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

      if (resp['message'] == "true") {
        final tipoIdModel = getRespWalletFromMap(resp['resp']);
        credito = tipoIdModel.data.creditoActual;
        debito = tipoIdModel.data.saldoActual;
        setState(() {
          
        });
        contabilidad =true;
        if (tipoIdModel.movimientos.length == 0) {
          vacio = 'vacio';
          setState(() {});
        } else {
          tipoIdModel.movimientos.forEach((element) {
            widgets.add(datos(context,
                fecha: element.createdAt.toString(),
                tipo: element.tipoMovimiento,
                valor: element.valorMovimiento.toString()));
          });
          globalRespMovimientos = [];
          globalRespMovimientos = widgets;
          setState(() {});
        }

        //  print('---------------------------------------------------------------------ok');
      }    if (resp['message'] == "false") {
        Navigator.pop(context);
          return alerta(context,
          // titulo: 'sa',
          contenido: 'error',
          code: false);}
    } catch (e) {
      Navigator.pop(context);
      return alerta(context,
          // titulo: 'sa',
          contenido: 'Ha ocurrido un problema, intentelo nuevamente.',
          code: false);
    }
  }
}
