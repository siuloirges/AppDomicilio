import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:traelo_app/src/utils/Widgets/elevacion_container.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
// import 'package:universal_platform/universal_platform.dart';

class PerfilAliado extends StatelessWidget {
  PreferenciasUsuario pref = new PreferenciasUsuario();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  Funciones funciones = new Funciones();
  var size;
  double t;
  Orientation orientation;
  dynamic element;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    t = size.width < 220
        ? 10: size.width < 300? 12: size.width < 400 ? 14 : size.width < 500? 16: size.width < 600? 18: 20;
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                image(context),
                contenido(context),
              ],
            ),
          ),
          pop(context),
        ],
      ),
    );
  }

  Widget pop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: amarillo),
          backgroundColor: Colors.transparent,
          title: Text(
            'Perfil',
            style: TextStyle(color: amarillo),
          ),
        )
      ],
    );
  }

  Widget image(BuildContext context) {
    double t = size.width < 200
        ? 10
        : size.width < 300
            ? 10
            : size.width < 400
                ? 12.5
                : size.width < 500
                    ? 13.5
                    : size.width < 600
                        ? 14
                        : 15;
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    child: Image(
                    // fadeOutCurve: Curves.ease,
                    fit:element['data']['url_foto_portada']!=null&&element['data']['url_foto_portada']!='no'? BoxFit.cover:BoxFit.scaleDown,
                    height: size.width < 400 ? size.height * 0.3 : 200,
                    width:element['data']['url_foto_portada']!=null&&element['data']['url_foto_portada']!='no'? double.infinity:100,
                    // placeholder:  AssetImage('assets/load.gif',),
                    image: NetworkImage('$storage${element['data']['url_foto_portada']}'),
                  )),
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/Rectangle.png',
                      height: size.width < 400 ? size.height * 0.3 : 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ],
                )
              ],
            ),
            Container(
              color: Colors.transparent,
              height: size.height * 0.05,
            )
          ],
        ),
        Container(
          height: size.width < 400 ? size.height * 0.3 : 200,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  element['data']['nombre'],
                  style:
                      TextStyle(color: amarillo, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  element['data']['razon_social'] ?? pref.nombre ?? '???',
                  style: TextStyle(color: blanco),
                ),
              ),
              SizedBox(height: size.width < 400 ? size.height * 0.05 : 20),
            ],
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.width < 400 ? size.height * 0.255 : 165),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Center(
                  child: Container(
                    height: 25,
                    width: size.width < 250
                        ? 80
                        : size.width < 450
                            ? size.width * 0.3
                            : size.width < 700
                                ? size.width * 0.26
                                : 160,
                    child: RaisedButton(
                      color: verde,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: t,
                          ),
                          Text(
                              size.width < 380
                                  ? "Editar"
                                  : size.width < 400
                                      ? 'Editar Pefil'
                                      : size.width < 660
                                          ? "Editar Pefil"
                                          : 'Editar Perfil',
                              style:
                                  TextStyle(fontSize: t, color: Colors.white)),
                        ],
                      ),
                      onPressed: pref.rol == 'asistente'
                          ? () {
                              Navigator.of(context)
                                  .pushNamed('EditarUsuarioAliado');
                            }
                          : () async {
                              load(context);
                              dynamic resp = await http.getMethod(
                                  context: context,
                                  table: 'get_user',
                                  token: pref.token);
                              print(pref.token);
                              if (resp['message'] == "expiro") {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .pushReplacementNamed('IniciarSesion');
                                alerta(context,
                                    titulo: 'alerta',
                                    code: false,
                                    contenido:
                                        'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                await funciones.closeSection(context);
                              }
                              if (resp['message'] == 'true') {

                                
                                //  return alerta(context,contenido: Text(resp['data']['nombre']));
                                Navigator.pop(context);
                                Navigator.of(context).pushNamed(
                                    'EditarPerfilAliado',
                                    arguments: {
                                      'data': resp['data'],
                                      'aliado': element['data']
                                    });
                              } else {
                                Navigator.pop(context);
                                return alerta(context,
                                    contenido: Text(resp['data']));
                              }
                              // print(resp['message']);
                            },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    radius: 35,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000),
                          child: Image.network(
                            element['data']['url_foto_perfil'] != 'no'
                                ? '$storage${element['data']['url_foto_perfil']}'
                                : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ51tAAbaUu2O4TyoIS1LMNylyR7LzOfeIdoA&usqp=CAU',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )),
                      radius: 34,
                    ),
                    backgroundColor: verde,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget contenido(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Ultimas ordenes',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: size.width < 550 ? size.width * 0.035 : 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Estado ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.width < 550 ? size.width * 0.035 : 15,
                    )),
              ),
            ],
          ),
        ),
        cardSucursales(
            context: context,
            precio: '\$ 20,000',
            subtitulo: 'Villa Grande Mz 14 Lt4',
            titulo: 'Orden D001',
            colorBoton: amarillo,
            colorTexto: Colors.black,
            nombreBoton: 'En Proceso'),
        cardSucursales(
            context: context,
            precio: '\$ 54,000',
            subtitulo: 'Olaya Herrera - Cll 12',
            titulo: 'Orden C999',
            colorBoton: Color.fromRGBO(1, 86, 255, 1),
            colorTexto: Colors.white,
            nombreBoton: 'En Transito'),
        SizedBox(
          height: size.width < 550 ? size.height * 0.02 : 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width < 550 ? size.width * 0.010 : 10,
              ),
              Text('Sucursales',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.width < 550 ? size.width * 0.035 : 20)),
            ],
          ),
        ),
        cardsPequenas(
          context: context,
          subtitulo: 'Salon de Comidas - La Plazuela',
          titulo: 'Mc Donalds',
        ),
        cardsPequenas(
          context: context,
          subtitulo: 'Salon de Comidas - La castellana',
          titulo: 'Mc Donalds Express',
        ),
      ],
    );
  }

  Widget cardSucursales(
      {BuildContext context,
      String precio,
      String titulo,
      String subtitulo,
      Color colorBoton,
      Color colorTexto,
      String nombreBoton}) {
    final size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(children: [
      Container(
        width: size.width,
        height: 80,
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
                  Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    // color: Colors.grey,
                    width: size.width < 257
                        ? 60
                        : size.width < 417
                            ? 120
                            : 200,
                    child: Text(subtitulo,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color.fromRGBO(103, 96, 95, 1))),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: size.width < 345 ? size.width * 0.27 : 120,
                      height: 20,
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                        color: colorBoton,
                        child: Text(
                          nombreBoton,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorTexto,
                            fontSize: size.width < 361 ? 10 : 13,
                          ),
                        ),
                      )),
                  SizedBox(width: size.width < 550 ? size.width * 0.03 : 10),
                  Icon(Icons.arrow_forward_ios, size: 12)
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        width: size.width,
        height: 25,
        child: Card(
          color: Color.fromRGBO(251, 251, 251, 1),
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      precio,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: verde),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        height: 6,
      )
    ]);
  }

  Widget cardsPequenas({
    BuildContext context,
    String titulo,
    String subtitulo,
  }) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: 60,
          color: Colors.white,
          child: Card(
            margin: const EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: size.width < 550 ? size.width * 0.03 : 14),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_business, color: verde),
                    ],
                  ),
                  SizedBox(width: size.width < 550 ? size.width * 0.01 : 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Container(
                          width: size.width * 0.8,
                          child: Text(titulo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Text(subtitulo,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(103, 96, 95, 1))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        )
      ],
    );
  }
}
