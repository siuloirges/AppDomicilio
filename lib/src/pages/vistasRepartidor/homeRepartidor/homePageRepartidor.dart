import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/Widgets/drawer/drawer.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/RastreoProvider.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import '../../../utils/Global.dart';
import 'model/respInicioRepartidorModel.dart';

class HomeRepartidor extends StatefulWidget {
  const HomeRepartidor({Key key}) : super(key: key);

  @override
  _HomeRepartidorState createState() => _HomeRepartidorState();
}

class _HomeRepartidorState extends State<HomeRepartidor> {
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  Funciones funciones = new Funciones();
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  RastreoProvider _rastreo;

  Size _size;
  String nuevas;
  String enTransito;
  String entregadas;
  bool busqueda = false;
  bool peticiones = false;
  @override
  Widget build(BuildContext context) {
    if (_pref.ultima_pagina != 'iniciorepartidor') {
      _pref.ultima_pagina = 'iniciorepartidor';
    }
    _rastreo = Provider.of<RastreoProvider>(context);
    _size = MediaQuery.of(context).size;
    if (peticiones == false) {
      pedir(context);
      peticiones = true;
      setState(() {});
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(_pref.nombre,
              style: TextStyle(fontSize: 20, color: Colors.black87)),
          actions: [
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {});
              },
            )
          ],
          iconTheme: IconThemeData(color: verde),
          backgroundColor: amarillo,
        ),
        drawer: MenuDesplegable(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: _size.width / 12.5,
            ),
            CircleAvatar(
              backgroundColor: verde,
              radius: _size.width < 380 ? _size.width * 0.093 : 40,
              child: _pref.url_foto_perfil != null
                  ? CircleAvatar(
                      radius: _size.width < 380 ? _size.width * 0.09 : 39,
                      backgroundImage:
                          NetworkImage(storage + _pref.url_foto_perfil),
                    )
                  : Container(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _size.width / 16,
              ),
              // _disponible(context),
              SizedBox(height: _size.width / 19),
              _credito(context),
              SizedBox(
                height: _size.width / 40,
              ),
              _texto(context),
              SizedBox(
                height: _size.width / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardPequenna(
                    titulo: 'Nuevas',
                    image: 'assets/notificationp.png',
                    asistente: true,
                    // cantidad: 5,
                    cantidadMod: busqueda == false
                        ? CircularProgressIndicator(
                            backgroundColor: amarillo,
                            strokeWidth: 1,
                          )
                        : Text(nuevas ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    _size.width > 589 ? 45.3 : _size.width / 13,
                                fontWeight: FontWeight.bold,
                                color: amarillo)),
                    colorTitulo: Colors.white,
                    colorNumero: Colors.white,
                    heroTag: '1',
                  ),
                  CardPequenna(
                    titulo: 'En transito',
                    image: 'assets/order1.png',
                    asistente: true,
                    cantidadMod: busqueda == false
                        ? CircularProgressIndicator(
                            backgroundColor: amarillo,
                            strokeWidth: 1,
                          )
                        : Text(enTransito ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    _size.width > 589 ? 45.3 : _size.width / 13,
                                fontWeight: FontWeight.bold,
                                color: amarillo)),
                    colorTitulo: Colors.white,
                    colorNumero: Colors.white,
                    heroTag: '2',
                  ),
                  CardPequenna(
                    titulo: 'Finalizadas hoy',
                    image: 'assets/tick.png',
                    asistente: true,
                    cantidadMod: busqueda == false
                        ? CircularProgressIndicator(
                            backgroundColor: amarillo,
                            strokeWidth: 1,
                          )
                        : Text(entregadas ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    _size.width > 589 ? 45.3 : _size.width / 13,
                                fontWeight: FontWeight.bold,
                                color: amarillo)),
                    colorTitulo: Colors.white,
                    colorNumero: Colors.white,
                    heroTag: '3',
                  ),
                ],
              ),
              //   cardPendientes(
              //   context: context,
              //   precio: '\$ 64,000',
              //   subtitulo: 'Orden D996',
              //   titulo: 'Torres la Plazuela - Apart 3',
              //   estadoRepartidor: 'Repartidor Asignado',
              //   colorBoton: Colors.black,
              //   colorTextoBoton: Colors.white,
              // ),
              //  cardPendiente(
              //   context: context,
              //   precio: '\$ 64,000',
              //   subtitulo: 'Orden D996',
              //   titulo: 'Torres la Plazuela - Apart 3',
              //   estadoRepartidor: 'Repartidor Asignado',
              //   colorBoton: Colors.black,
              //   colorTextoBoton: Colors.white,
              // ),
            ],
          ),
        ));
  }

  Widget _disponible(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: _size.width < 500 ? _size.width * 0.3 : 160,
            child: RaisedButton(
                color: _rastreo.getStatus ? amarillo : gris,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  _rastreo.getStatus ? 'Disponible' : 'No Disponible',
                  style: TextStyle(
                      fontSize: 10, color: _rastreo.getStatus ? verde : negro),
                ),
                // onPressed: () {
                //   alerta(
                //     context,
                //     titulo: "Nuevo pedido!",
                //     contenido: Column(
                //       children: [
                //         Row(
                //           children: [
                //             Text(
                //               'Direccion succursal: ',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Container(
                //                 width: _size.width * 0.5,
                //                 child: Text(
                //                   "San jose de los campanos carrera 98 # 39 E 84",
                //                   overflow: TextOverflow.visible,
                //                 )),
                //           ],
                //         ),
                //         SizedBox(height: 15),
                //         Row(
                //           children: [
                //             Text(
                //               'Direccion Destino: ',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Container(
                //                 width: _size.width * 0.5,
                //                 child: Text(
                //                   "San jose de los campanos carrera 98 # 39 E 84",
                //                   overflow: TextOverflow.visible,
                //                 )),
                //           ],
                //         ),
                //           SizedBox(height: 15),
                //            Row(
                //           children: [
                //             Text(
                //               'Valor domicilio:',
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //           ],
                //         ),
                //          Row(
                //           children: [
                //             Container(
                //                 width: _size.width * 0.5,
                //                 child: Text(
                //                   "\$50.000",
                //                   overflow: TextOverflow.visible,
                //                 )),
                //           ],
                //         ),
                //           SizedBox(height: 15),
                //            Row(
                //              mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             GestureDetector(
                //               onTap: (){   },
                //                                         child: Container(
                //                 color: Colors.transparent,
                //                 child: Text(
                //                   'Ver productos',
                //                   style: TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),

                //       ],
                //     ),
                //     acciones: Container(
                //       width: _size.width*0.6,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //         RaisedButton(onPressed: (){},color: rojo,child: Text("Rezhazar",style:TextStyle(color: blanco)),shape: StadiumBorder(),),
                //         RaisedButton(onPressed: (){}, color: verde,child: Text("Tomar!",style:TextStyle(color: blanco)),shape: StadiumBorder(),)
                //         ],
                //       ),
                //     ),
                //     colorTitulo: verde,
                //   );
                // },
                onPressed: () async {
                  bool status = await geolocator.isLocationServiceEnabled();
                  if (!status && !_rastreo.getStatus) {
                    _showDialogGps(geolocator);
                  } else {
                    _rastreo.toggle();
                  }
                }),
          ),
        ),
      ],
    );
  }

  _showDialogGps(Geolocator geolocator) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          backgroundColor: Color.fromRGBO(246, 245, 250, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: ShapeDecoration(
                    color: blanco,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text("Obligatorio"),
                  )),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 50.0,
              ),
              Text("Activa GPS para Continuar"),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: _size.width,
                    child: RaisedButton(
                      color: verde,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new Text("Listo!",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        bool status =
                            await geolocator.isLocationServiceEnabled();
                        if (status) return Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _credito(BuildContext context) {
    return _size.width > 424
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nivelDeConfianza(context),
              Stack(
                children: [
                  Image(
                    width: _size.width < 360 ? _size.width * 0.6 : 300,
                    height: 100,
                    image: AssetImage('assets/credito.png'),
                    // centerSlice:Rect.zero ,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    //  color: Colors.black38,
                    width: _size.width < 360 ? _size.width * 0.6 : 300,
                    height: 85,
                    child: Center(
                      child: Text(
                        '\$150,000',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nivelDeConfianza(context),
              Stack(
                children: [
                  Image(
                    width: 300,
                    height: 100,
                    image: AssetImage('assets/credito.png'),
                    // centerSlice:Rect.zero ,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    //  color: Colors.black38,
                    width: 300,
                    height: 85,
                    child: Center(
                      child: Text(
                        '\$150,000',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
  }

  Widget _nivelDeConfianza(BuildContext context) {
    return Column(
      children: [
        Text('Nivel de Confianza',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/honor.png',
              width: 30,
            ),
            Text('1',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ],
        )
      ],
    );
  }

  Widget _texto(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Entregas',
          style:
              TextStyle(color: verde, fontSize: 0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  pedir(context, {bool vehiculo = false}) async {
    final size = MediaQuery.of(context).size;
    try {
      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'pedido?repartidor_id=${_pref.user_id}&all=1',
        token: _pref.token,
      );
      if (resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }
      if (resp['message'] == "true") {
        final respInicioRepartidorModel =
            respInicioRepartidorModelFromJson(resp['resp']);
        setState(() {
          nuevas = respInicioRepartidorModel.autorizada.toString();
          enTransito = respInicioRepartidorModel.enTransito.toString();
          entregadas = respInicioRepartidorModel.entregada.toString();
          busqueda = true;
        });
      }
      if (resp['message'] == "false") {
        return alerta(context,
            code: false,
            contenido: 'Ha ocurrido un error intentelo nuevamente.');
      }
    } catch (e) {
      return alerta(context, contenido: '$e', code: false);
    }
  }
}
