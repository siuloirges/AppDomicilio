import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAsistente/models/sucursal_asistente_model.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/respGetProductos.dart';
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/provider/productoprovider.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAliado/models/SucursalModel.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAsistente/models/SucursalModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/direccion/models/DireccionModel.dart';
import 'package:traelo_app/src/pages/vistasCliente/direccion/models/GetDireccionModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:http/http.dart' as peticiones;
import 'package:traelo_app/src/utils/model/respGetProductos.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';
import '../../preferencias.dart';

class MenuDesplegable extends StatelessWidget {
  Funciones funciones = new Funciones();
  ProductoProvider productosProvider = new ProductoProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Drawer(
      elevation: 20.0,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: orientation == Orientation.portrait
                    ? size.height * 0.06
                    : size.height * 0.106,
              ),
              Image(
                image: AssetImage('assets/logo.png'),
                // color: verde,
                width: 130,
              ),
              SizedBox(
                height: 15,
              ),
              // Text(
              //   'Pi 3.14',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 25),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              Divider(),
              Container(
                child: pref.rol == "cliente"
                    ? Column(
                        children: [
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.1
                                : size.height * 0.176,
                          ),

                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context).pushNamed('Perfil');
                            },
                            title: Text('Perfil Cliente'),
                            leading: Image(
                              image: AssetImage('assets/profile.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () async {
                              load(context);
                              try {
                                Map _respuesta = await http.getMethod(
                                    context: context,
                                    table: 'direcciones',
                                    token: pref.token);
                                if (_respuesta['message'] == "expiro") {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacementNamed('IniciarSesion');
                                  alerta(context,
                                      titulo: 'alerta',
                                      code: false,
                                      contenido:
                                          'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                  await funciones.closeSection(context);
                                } else {}
                                if (_respuesta['message'] == 'true') {
                                  final respModel = getDireccionesModelFromJson(
                                      _respuesta['resp']);
                                  print(respModel.data.data);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Scaffold.of(context).openEndDrawer();
                                  Navigator.of(context).pushNamed(
                                      'MisDirecciones',
                                      arguments: {"data": respModel.data.data});
                                } else {}
                              } catch (error) {
                                Navigator.pop(context);
                                Scaffold.of(context).openEndDrawer();
                                return alerta(context,
                                    code: false,
                                    contenido: error,
                                    acciones: Container());
                              }

                              // Scaffold.of(context).openEndDrawer();
                              // Navigator.of(context).pushNamed('MisDirecciones');
                            },
                            title: Text('Direcciones Cliente'),
                            leading: Image(
                              image: AssetImage('assets/pin.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context)
                                  .pushNamed('MisOrdenes', arguments: {
                                "indice": 0,
                                "page": 0,
                              });
                            },
                            title: Text('Mi Orden Cliente'),
                            leading: Image(
                              image: AssetImage('assets/order.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     // Scaffold.of(context).openEndDrawer();
                          //     Navigator.of(context).pushNamed('');
                          //   },
                          //   title: Text('Buscar Cliente'),
                          //   leading: Image(
                          //     image: AssetImage('assets/search.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Scaffold.of(context).openEndDrawer();
                          //     Navigator.of(context).pushNamed('Contactanos');
                          //   },
                          //   title: Text('Contactanos Cliente'),
                          //   leading: Image(
                          //     image: AssetImage('assets/mail.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                        ],
                      )
                    : Container(),
              ),
              Container(
                child: pref.rol == 'aliado'
                    ? Column(
                        children: [
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.06
                                : size.height * 0.106,
                          ),
                          ListTile(
                            onTap: () async {
                              load(context);
                              dynamic resp = await http.showMethod(
                                  context: context,
                                  table: 'aliado',
                                  id: pref.id_aliado,
                                  token: pref.token);
                              // print(resp['data']);
                              if (resp['message'] == "expiro") {
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
                                Scaffold.of(context).openEndDrawer();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, 'PerfilAliado',
                                    arguments: resp);
                              } else {
                                alerta(context, contenido: resp['data']);
                              }
                            },
                            title: Text('Perfil Aliados '),
                            leading: Image(
                              image: AssetImage('assets/profile.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () async {
                              // Scaffold.of(context).openEndDrawer();
                              load(context);
                              try {
                                var resp = await productosProvider
                                    .obtenerProducto(context)
                                    .timeout(Duration(seconds: 10),
                                        onTimeout: () {
                                  throw {
                                    Navigator.pop(context),
                                    alerta(context,
                                        contenido: Text(
                                            "No hay conexion con el servidor."),
                                        acciones: Container()),
                                  };
                                });

                                Map<dynamic, dynamic> decodedResp =
                                    jsonDecode(resp);
                                // if (decodedResp['message'] ==
                                //     'Unauthenticated.') {
                                //   Navigator.pop(context);
                                //   Navigator.of(context)
                                //       .pushReplacementNamed('IniciarSesion');
                                //   alerta(context,
                                //       titulo: 'alerta',
                                //       code: false,
                                //       contenido:
                                //           'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                //   await funciones.closeSection(context);
                                // }
                                if (decodedResp['success']) {
                                  var respModel = respProductoFromJson(resp);
                                  Navigator.pop(context);
                                  Scaffold.of(context).openEndDrawer();
                                  Navigator.of(context).pushNamed(
                                      'ProductosAliados',
                                      arguments: respModel.data);
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                Scaffold.of(context).openEndDrawer();
                                alerta(context,
                                    contenido: Text('$e'),
                                    acciones: Container());
                              }
                            },
                            title: Text('Producto Aliados'),
                            leading: Image(
                              image: AssetImage('assets/Producto.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context)
                                  .pushNamed('MisOrdenesAliado', arguments: {
                                'aliado': true,
                                "indice": 0,
                                "page": 0,
                              });
                            },
                            title: Text('Ordenes Aliados'),
                            leading: Image(
                              image: AssetImage('assets/order.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () async {
                              load(context);
                              try {
                                Map _respuesta = await http.getMethod(
                                    context: context,
                                    table: 'sucursales',
                                    token: pref.token);
                                //  print(_respuesta);
                                if (_respuesta['message'] == "expiro") {
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
                                if (_respuesta['message'] == 'true') {
                                  var respModel =
                                      respSucursalFromJson(_respuesta['resp']);
                                  Navigator.pop(context);
                                  Scaffold.of(context).openEndDrawer();
                                  Navigator.of(context).pushNamed(
                                      'SucursalAliado',
                                      arguments: {"data": respModel.data.data});
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                Scaffold.of(context).openEndDrawer();
                                return alerta(context,
                                    contenido: Text(e), acciones: Container());
                              }

                              // Navigator.of(context).pushNamed('SucursalAliado');
                            },
                            title: Text('Sucursal Aliados'),
                            leading: Image(
                              image: AssetImage('assets/company.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     Scaffold.of(context).openEndDrawer();
                          //     Navigator.of(context).pushNamed('BalanceAlliado');
                          //   },
                          //   title: Text('Balance Aliados'),
                          //   leading: Image(
                          //     image: AssetImage('assets/value.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context).pushNamed('UsuariosAliado');
                            },
                            title: Text('Usuarios Aliados'),
                            leading: Image(
                              image: AssetImage('assets/consultante.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                        ],
                      )
                    : Container(),
              ),

              Container(
                  child: pref.rol == 'asistente'
                      ? Column(
                          children: [
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.06
                                  : size.height * 0.106,
                            ),
                            // ListTile(
                            //   onTap: () {
                            //     Scaffold.of(context).openEndDrawer();
                            //     Navigator.of(context).pushNamed('InicioAliado');
                            //   },
                            //   title: Text('Inicio Aliados'),
                            //   leading: Image(
                            //     image: AssetImage('assets/home-run.png'),
                            //     width: orientation == Orientation.portrait
                            //         ? size.width * 0.1
                            //         : size.width * 0.056,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: orientation == Orientation.portrait
                            //       ? size.height * 0.02
                            //       : size.height * 0.037,
                            // ),
                            ListTile(
                              onTap: () async {
                                load(context);
                                dynamic resp = await http.showMethod(
                                  context: context,
                                  table: 'aliado',
                                  id: pref.id_aliado,
                                  token: pref.token,
                                );
                                // print(resp['data']);
                                if (resp['message'] == "expiro") {
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
                                  Scaffold.of(context).openEndDrawer();
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, 'PerfilAliado',
                                      arguments: resp);
                                } else {
                                  alerta(context, contenido: resp['data']);
                                }
                              },
                              title: Text('Perfil Aliados '),
                              leading: Image(
                                image: AssetImage('assets/company.png'),
                                // color: Colors.grey,
                                width: orientation == Orientation.portrait
                                    ? size.width * 0.1
                                    : size.width * 0.056,
                              ),
                            ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.02
                                  : size.height * 0.037,
                            ),
                            ListTile(
                              onTap: () async {
                                // Scaffold.of(context).openEndDrawer();
                                load(context);
                                try {
                                  var resp = await productosProvider
                                      .obtenerProducto(context)
                                      .timeout(Duration(seconds: 10),
                                          onTimeout: () {
                                    throw {
                                      Navigator.pop(context),
                                      alerta(context,
                                          contenido: Text(
                                              "No hay conexion con el servidor."),
                                          acciones: Container()),
                                    };
                                  });

                                  Map<dynamic, dynamic> decodedResp =
                                      jsonDecode(resp);
                                  if (decodedResp['message'] ==
                                      'Unauthenticated.') {
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

                                  if (decodedResp['success']) {
                                    var respModel = respProductoFromJson(resp);
                                    Navigator.pop(context);
                                    Scaffold.of(context).openEndDrawer();
                                    Navigator.of(context).pushNamed(
                                        'ProductosAliados',
                                        arguments: respModel.data);
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  Scaffold.of(context).openEndDrawer();
                                  alerta(context,
                                      contenido: Text(e),
                                      acciones: Container());
                                }
                              },
                              title: Text('Producto Asistente'),
                              leading: Image(
                                image: AssetImage('assets/Producto.png'),
                                // color: Colors.grey,
                                width: orientation == Orientation.portrait
                                    ? size.width * 0.1
                                    : size.width * 0.056,
                              ),
                            ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.02
                                  : size.height * 0.037,
                            ),
                            ListTile(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                                Navigator.of(context)
                                    .pushNamed('MisOrdenesAliado', arguments: {
                                  'aliado': false,
                                  "indice": 0,
                                  "page": 0,
                                });
                              },
                              title: Text('Ordenes Asistente'),
                              leading: Image(
                                image: AssetImage('assets/order.png'),
                                // color: Colors.grey,
                                width: orientation == Orientation.portrait
                                    ? size.width * 0.1
                                    : size.width * 0.056,
                              ),
                            ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.02
                                  : size.height * 0.037,
                            ),
                            ListTile(
                              onTap: () async {
                                load(context);
                                try {
                                  Map _respuesta = await http.getMethod(
                                      context: context,
                                      table:
                                          'sucursales?id_asistente=${pref.user_id}',
                                      token: pref.token);
                                  //  print(_respuesta);
                                  if (_respuesta['message'] == "expiro") {
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
                                  if (_respuesta['message'] == 'true') {
                                    var respModel = sucursalesModelFromJson(
                                        _respuesta['resp']);
                                    Navigator.pop(context);
                                    Scaffold.of(context).openEndDrawer();
                                    Navigator.of(context).pushNamed(
                                        'SucursalAsistente',
                                        arguments: {"dato": respModel.data});
                                  }
                                } catch (e) {
                                  Navigator.pop(context);
                                  Scaffold.of(context).openEndDrawer();
                                  return alerta(context,
                                      contenido: Text(e),
                                      acciones: Container());
                                }

                                // Navigator.of(context).pushNamed('SucursalAliado');
                              },
                              title: Text('Sucursal Asistente'),
                              leading: Image(
                                image: AssetImage('assets/company.png'),
                                // color: Colors.grey,
                                width: orientation == Orientation.portrait
                                    ? size.width * 0.1
                                    : size.width * 0.056,
                              ),
                            ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.02
                                  : size.height * 0.037,
                            ),
                            // ListTile(
                            //   onTap: () {
                            //     Scaffold.of(context).openEndDrawer();
                            //     Navigator.of(context)
                            //         .pushNamed('BalanceAlliado');
                            //   },
                            //   title: Text('Balance Aliados'),
                            //   leading: Image(
                            //     image: AssetImage('assets/value.png'),
                            //     width: orientation == Orientation.portrait
                            //         ? size.width * 0.1
                            //         : size.width * 0.056,
                            //   ),
                            // ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? size.height * 0.02
                                  : size.height * 0.037,
                            ),
                            // ListTile(
                            //   onTap: () {
                            //     Scaffold.of(context).openEndDrawer();
                            //     Navigator.of(context)
                            //         .pushNamed('UsuariosAliado');
                            //   },
                            //   title: Text('Usuarios Aliados'),
                            //   leading: Image(
                            //     image: AssetImage('assets/company.png'),
                            //     width: orientation == Orientation.portrait
                            //         ? size.width * 0.1
                            //         : size.width * 0.056,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: orientation == Orientation.portrait
                            //       ? size.height * 0.02
                            //       : size.height * 0.037,
                            // ),
                          ],
                        )
                      : Container()),

              // ListTile(
              //   onTap: () {
              //     Scaffold.of(context).openEndDrawer();
              //     Navigator.of(context).pushNamed('IniciarSesion');
              //   },
              //   title: Text('Cerrar Sesión'),
              //   leading: Image(
              //     image: AssetImage('assets/logout.png'),
              //     width: orientation == Orientation.portrait
              //         ? size.width * 0.1
              //         : size.width * 0.056,
              //   ),
              // ),
              //*aqui terminan los iconos drawer aliado_____________________________________________________________________________________________________________

              //*aqui empie   nos drawer repartidor_____________________________________________________________________________________________________________

              Container(
                child: pref.rol == 'repartidor'
                    ? Column(
                        children: [
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.06
                                : size.height * 0.106,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     Scaffold.of(context).openEndDrawer();
                          //     Navigator.of(context).pushNamed('inicioRepartidor');
                          //   },
                          //   title: Text('Inicio Repartidor'),
                          //   leading: Image(
                          //     image: AssetImage('assets/home-run.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context)
                                  .pushNamed('PerfilRepartidor');
                            },
                            title: Text('Perfil Repartidor'),
                            leading: Image(
                              image: AssetImage('assets/food-delivery.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context)
                                  .pushNamed('OrdenesRepartidor', arguments: {
                                'aliado': true,
                                "indice": 0,
                                "page": 0,
                              });
                            },
                            title: Text('Ordenes Repartidor'),
                            leading: Image(
                              image: AssetImage('assets/order.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                          ListTile(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                              Navigator.of(context).pushNamed('WalletPage');
                            },
                            title: Text('Wallet Repartidor'),
                            leading: Image(
                              image: AssetImage('assets/wallet.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context).pushNamed('soporte');
                          //     Scaffold.of(context).openEndDrawer();
                          //   },
                          //   title: Text('Soporte Repartidor'),
                          //   leading: Image(
                          //     image: AssetImage('assets/consultante.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.02
                                : size.height * 0.037,
                          ),
                        ],
                      )
                    : Container(),
              ),
              // SizedBox(
              //   height: orientation == Orientation.portrait
              //       ? size.height * 0.02
              //       : size.height * 0.037,
              // ),
              // ListTile(F
              //   onTap: () {
              //     Scaffold.of(context).openEndDrawer();
              //     Navigator.of(context).pushNamed('SucursalAliado');
              //   },
              //   title: Text('Sucursal'),
              //   leading: Image(
              //     image: AssetImage('assets/profile.png'),
              //     width: orientation == Orientation.portrait
              //         ? size.width * 0.1
              //         : size.width * 0.056,
              //   ),
              // ),
              // SizedBox(
              //   height: orientation == Orientation.portrait
              //       ? size.height * 0.02
              //       : size.height * 0.037,
              // ),
              // ListTile(
              //   onTap: () {
              //     Scaffold.of(context).openEndDrawer();
              //     Navigator.of(context).pushNamed('BalanceAlliado');
              //   },
              //   title: Text('Balance'),
              //   leading: Image(
              //     image: AssetImage('assets/profile.png'),
              //     width: orientation == Orientation.portrait
              //         ? size.width * 0.1
              //         : size.width * 0.056,
              //   ),
              // ),

              // ListTile(
              //   onTap: () {
              //     Navigator.of(context).pushNamed('IniciarSesion');
              //   },
              //   title: Text('Cerrar Sesión'),
              //   leading: Image(
              //     image: AssetImage('assets/logout.png'),
              //     width: orientation == Orientation.portrait
              //         ? size.width * 0.1
              //         : size.width * 0.056,
              //   ),
              // ),

              //*aqui terminan los iconos drawer repartidor_____________________________________________________________________________________________________________
              //*aqui empiezan los iconos drawer Administrador_____________________________________________________________________________________________________________

              //*aqui terminan los iconos drawer Administrador_________________________________________________________________________________

              //aqui empiezan los iconos drawer administrador____________________________________________________________
              Container(
                child: pref.rol == 'administrador'
                    ? Column(
                        children: [
                          SizedBox(
                            height: orientation == Orientation.portrait
                                ? size.height * 0.06
                                : size.height * 0.106,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context).pushNamed('inicioAdministrador');
                          //   },
                          //   title: Text('Inicio Administrador'),
                          //   leading: Image(
                          //       image: AssetImage('assets/home-run.png'),
                          //       width: orientation == Orientation.portrait
                          //           ? size.width * 0.1
                          //           : size.width * 0.056),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          //
                          //
                          //
                          //
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed('ordenesAdminPage');
                          //   },
                          //   title: Text('Ordenes Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/order.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('UsuariosAdministrador');
                            },
                            title: Text('Usuarios Administrador'),
                            leading: Image(
                              image: AssetImage('assets/grupo.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed('RepartidoresAdministradores');
                          //   },
                          //   title: Text('Repartidores Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/food-delivery.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.024
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed('AliadosAdministrador');
                          //   },
                          //   title: Text('Aliados Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/company.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed('ClientesAdministrador');
                          //   },
                          //   title: Text('Clientes Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/grupo.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed('Crear');
                            },
                            title: Text('Crear - administrador'),
                            leading: Image(
                              image: AssetImage('assets/order.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed('Estadisticas');
                            },
                            title: Text('Estadisticas Administrador'),
                            leading: Image(
                              image: AssetImage('assets/dinero.png'),
                              // color: Colors.grey,
                              width: orientation == Orientation.portrait
                                  ? size.width * 0.1
                                  : size.width * 0.056,
                            ),
                          ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed('ConsultasAdministrador');
                          //   },
                          //   title: Text('Consultas Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/reporte.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: orientation == Orientation.portrait
                          //       ? size.height * 0.02
                          //       : size.height * 0.037,
                          // ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context).pushNamed('PruebaWidget');
                          //   },
                          //   title: Text('Balance Administrador'),
                          //   leading: Image(
                          //     image: AssetImage('assets/value.png'),
                          //     // color: Colors.grey,
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),

                          // ListTile(
                          //   onTap: () {
                          //     Navigator.of(context).pushReplacementNamed('IniciarSesion');
                          //   },
                          //   title: Text('Cerrar Sesion Global'),
                          //   leading: Image(
                          //     image: AssetImage('assets/logout.png'),
                          //     width: orientation == Orientation.portrait
                          //         ? size.width * 0.1
                          //         : size.width * 0.056,
                          //   ),
                          // ),

                          // SizedBox(
                          //   height: size.height * 0.07,
                          // ),

                          // Divider(),
                          // SizedBox(
                          //   height: size.height * 0.008,
                          // ),
                          // Text('Desarrollado Por'),
                          // Text(
                          //   'ZIONENTERPRISE',
                          //   style: TextStyle(
                          //       color: Color.fromRGBO(19, 166, 7, 1),
                          //       fontWeight: FontWeight.bold),
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.05,
                          // ),
                        ],
                      )
                    : Container(),
              ),
              ListTile(
                onTap: () async {
                  load(context);
                  await funciones.closeSection(context);
                  Navigator.pop(context);
                  Scaffold.of(context).openEndDrawer();
                  Navigator.of(context).pushReplacementNamed('IniciarSesion');

                  //   try{

                  //   Map<String,String> head = {'Accept': 'application/json','Content-Type': 'application/json','Authorization':'Bearer ${pref.token}'};
                  //   dynamic  resp = await peticiones.get('$url/logout',headers: head);
                  //   print(resp.body);
                  //   Navigator.of(context).pushReplacementNamed('IniciarSesion');

                  //  //TODO  BORRAR PREFERENCIAS
                  //  }catch(e){

                  //    print(e);
                  //   Navigator.of(context).pushReplacementNamed('IniciarSesion');
                  //  }
                },
                title: Text('Cerrar Sesion Global'),
                leading: Image(
                  image: AssetImage('assets/logout.png'),
                  // color: Colors.grey,
                  width: orientation == Orientation.portrait
                      ? size.width * 0.1
                      : size.width * 0.056,
                ),
              ),
            ],
          ),

          // color: Color.fromRGBO(61, 197, 37, 1),
        ),
      ),
    );
  }
}
