import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAsistente/models/inicioEmpleadoModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';
import 'package:traelo_app/src/utils/Widgets/drawer/drawer.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/RefrescarToken.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

// import 'package:flutter/material.dart';

class InicioAliado extends StatefulWidget {
  // PreferenciasUsuario prefs =new PreferenciasUsuario();
  @override
  _InicioAliadoState createState() => _InicioAliadoState();
}

class _InicioAliadoState extends State<InicioAliado> {
  RefrescarTokenProvider _refrescarToken = new RefrescarTokenProvider();
  int variable = 0;
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  Funciones funciones = new Funciones();
  String nombreSucursal = '';
  String urlFotoSucursal = null;
  String nuevas;
  String pendientes;
  String entregadas;
  String canceladas;
  String total;
  bool peticiones = false;
  bool busqueda = false;
  int totalOrdenes;
  @override
  Widget build(BuildContext context) {
    if (peticiones == false) {
      pedir(context);
      peticiones = true;
      setState(() {});
    }
    if (prefs.ultima_pagina != 'inicioaliado') {
      prefs.ultima_pagina = 'inicioaliado';
    }
    return Scaffold(
        drawer: MenuDesplegable(),
        appBar: AppBar(
          // leading: IconButton(icon: Icon(Icons.directions_railway_rounded), onPressed:(){
          leading: Builder(builder: (context) {
            return IconButton(
                icon: Image(image: AssetImage('assets/menu.png')),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
          // }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: ShapeDecoration(
                    gradient: LinearGradient(colors: [verdeClaro, Colors.teal]),
                    // color: blanco,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // side: BorderSide(width: 2)
                    )),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('PublicarAliado');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Publicar Aliado',
                          style: TextStyle(
                              color: blanco, fontWeight: FontWeight.bold)),
                      Container(
                        width: 5,
                      ),
                      Icon(
                        Icons.upload_rounded,
                        color: blanco,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
          // toolbarHeight: orientacion == Orientation.portrait
          //     ? size.height * 0.1
          //     : size.height * 0.17,
          iconTheme: IconThemeData(color: verde),
          backgroundColor: amarillo,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${prefs.nombre}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Text(
                "${prefs.numero_documento}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ],
          ),
          elevation: 0.0,
        ),
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      body(context),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          // color: Colors.grey[200],
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                urlFotoSucursal != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(storage + urlFotoSucursal),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Center(
          child: busqueda == false
              ? Row(
                  children: [
                    Text(
                      'ORDENES: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Color.fromRGBO(19, 166, 7, 1),
                          letterSpacing: 2),
                    ),
                    CircularProgressIndicator(
                      backgroundColor: amarillo,
                      strokeWidth: 1,
                    )
                  ],
                )
              : Text(
                  'ORDENES: ' + '${totalOrdenes.toString() ?? '0'}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color.fromRGBO(19, 166, 7, 1),
                      letterSpacing: 2),
                ),
        ),
        Container(
            width: size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardPequenna(
                  aliado: true,
                  asistente: true,
                  colorNumero: amarillo,
                  titulo: 'NUEVAS',
                  colorTitulo: blanco,
                  cantidadMod: busqueda == false
                      ? CircularProgressIndicator(
                          backgroundColor: amarillo,
                          strokeWidth: 1,
                        )
                      : Text(nuevas ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  size.width > 589 ? 45.3 : size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: amarillo ?? Colors.black)),
                ),
                CardPequenna(
                  aliado: true,
                  asistente: true,
                  colorNumero: amarillo,
                  titulo: 'PENDIENTES',
                  colorTitulo: blanco,
                  cantidadMod: busqueda == false
                      ? CircularProgressIndicator(
                          backgroundColor: amarillo,
                          strokeWidth: 1,
                        )
                      : Text(pendientes ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  size.width > 589 ? 45.3 : size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: amarillo ?? Colors.black)),
                ),
              ],
            )),
        Container(
            width: size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardPequenna(
                  aliado: true,
                  asistente: true,
                  colorCard: blanco,
                  colorNumero: verde,
                  colorFloat: verde,
                  colorTitulo: verde,
                  titulo: 'CANCELADAS',
                  ontap: () {},
                  cantidadMod: busqueda == false
                      ? CircularProgressIndicator(
                          backgroundColor: amarillo,
                          strokeWidth: 1,
                        )
                      : Text(canceladas ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  size.width > 589 ? 45.3 : size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: verde ?? Colors.black)),
                ),
                CardPequenna(
                  aliado: true,
                  asistente: true,
                  colorCard: blanco,
                  colorNumero: verde,
                  colorTitulo: verde,
                  colorFloat: verde,
                  titulo: 'ENTREGADAS',
                  ontap: () {},
                  cantidadMod: busqueda == false
                      ? CircularProgressIndicator(
                          backgroundColor: amarillo, strokeWidth: 1)
                      : Text(entregadas ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  size.width > 589 ? 45.3 : size.width / 13,
                              fontWeight: FontWeight.bold,
                              color: verde ?? Colors.black)),
                ),
              ],
            )),
      ],
    );
  }

  pedir(context, {bool vehiculo = false}) async {
    final size = MediaQuery.of(context).size;
    try {
      List<Widget> widgets = [];
      dynamic resp = await http.getMethod(
        context: context,
        table: 'pedido?aliado_id=${prefs.id_aliado}&all=1',
        token: prefs.token,
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
        int calculoPendientes;
        int total;
        final sucursalesModel = homeAsistenteModelFromJson(resp['resp']);
        setState(() {
          urlFotoSucursal = sucursalesModel.urlFotoPerfil;
          calculoPendientes =
              sucursalesModel.preparada + sucursalesModel.autorizada;
          pendientes = calculoPendientes.toString();
          nuevas = sucursalesModel.generadas.toString();
          canceladas = sucursalesModel.cancelada.toString();
          entregadas = sucursalesModel.entregada.toString();
          total = sucursalesModel.preparada +
              sucursalesModel.autorizada +
              sucursalesModel.generadas +
              sucursalesModel.cancelada +
              sucursalesModel.entregada;
          totalOrdenes = total;
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
