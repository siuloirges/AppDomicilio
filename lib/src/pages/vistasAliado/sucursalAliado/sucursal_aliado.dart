import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAliado/inicioAsistente/models/sucursal_asistente_model.dart';
import 'package:traelo_app/src/pages/vistasAliado/perfilAliado/editarUsuario.dart';
import 'package:traelo_app/src/pages/vistasAliado/sucursalAsistente/models/SucursalModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'models/SucursalModel.dart';

// import 'models/SucursalModel.dart';

class SucursalAliado extends StatelessWidget {
  PreferenciasUsuario pref = PreferenciasUsuario();
  dynamic element;
  Funciones funciones = new Funciones();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  Size size;
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;

    size = MediaQuery.of(context).size;
    final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () {
              print(pref.token);
              Navigator.of(context)
                  .pushNamed('NuevaSucursal', arguments: {"data": null});
            },
            backgroundColor: amarillo,
            child: Icon(
              Icons.add,
              color: verde,
            )),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: () {
                copiarSucursal(context, element);
              },
              child: Row(
                children: [
                  Text(
                    'Duplicar sucursal',
                    style: TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: verde,
                    ),
                  ),
                ],
              ),
            )
          ],
          iconTheme: IconThemeData(color: verde),
          backgroundColor: amarillo,
          title: Text(
            "Sucursal",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          elevation: 0.0,
        ),
        body: element['data'].length != 0
            ? ListView.builder(
                itemCount: element['data'].length,
                itemBuilder: (BuildContext c, i) {
                  return sucursal(
                      context: context,
                      subtitulo: element['data'][i].nombre.toString(),
                      titulo: element['data'][i].telefono.toString(),
                      id: element['data'][i].id,
                      sucursal: element['data'][i]);
                })
            : thereIsNot(
                imagen: 'assets/no_hay.png', texto: 'No hay sucursales'));
  }

  Widget sucursal({
    BuildContext context,
    String titulo,
    String subtitulo,
    int id,
    dynamic sucursal,
  }) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: size.width,
        height: 80,
        color: Colors.white,
        child: Card(
          margin: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'MenuSucursal', arguments: {
                      'sucursal': sucursal,
                    });
                  },
                  // color: Colors.teal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: size.width * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_business, color: verde),
                        ],
                      ),
                      SizedBox(width: size.width * 0.01),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width < 322
                                ? size.width * 0.5
                                : size.width < 570
                                    ? size.width * 0.6
                                    : size.width * 0.7,
                            //color: Colors.grey,
                            child: Text(
                              subtitulo,
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
                                ? size.width * 0.5
                                : size.width < 570
                                    ? size.width * 0.6
                                    : size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(titulo,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: size.width < 436
                                            ? 12.2
                                            : size.width > 540
                                                ? 15.12
                                                : size.width * 0.028,
                                        color: Color.fromRGBO(103, 96, 95, 1))),
                                Text(sucursal.estado,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: size.width < 436
                                            ? 12.2
                                            : size.width > 540
                                                ? 15.12
                                                : size.width * 0.028,
                                        color: sucursal.estado == 'abierto'
                                            ? verde
                                            : sucursal.estado == "cerrado"
                                                ? rojo
                                                : Colors.blueGrey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pushNamed('NuevaSucursal',
                                    arguments: {"data": sucursal});
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: amarillo,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.edit,
                                  size: size.width > 642
                                      ? 16.05
                                      : size.width * 0.025,
                                  color: verde,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Column(
                                            children: [
                                              Text(
                                                '¿Estas seguro que ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'deseas eliminar',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                ' esta sucrusal?',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.03),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: size.width < 246
                                                        ? 43
                                                        : 50,
                                                    height: size.height * 0.045,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        'NO',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width < 246
                                                                    ? 7
                                                                    : 10),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color: rojo,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: size.width < 218
                                                          ? 1
                                                          : size.width < 323
                                                              ? 5
                                                              : size.width *
                                                                  0.04),
                                                  Container(
                                                    width: size.width < 246
                                                        ? 40
                                                        : 50,
                                                    height: size.height * 0.045,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        'SI',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: verde,
                                                            fontSize:
                                                                size.width < 246
                                                                    ? 8
                                                                    : 10),
                                                      ),
                                                      onPressed: () async {
                                                        try {
                                                          load(context);
                                                          dynamic resp =
                                                              await http.deleteMethod(
                                                                  context:
                                                                      context,
                                                                  table:
                                                                      'sucursales',
                                                                  id: id
                                                                      .toInt(),
                                                                  token: pref
                                                                      .token);
                                                          Navigator.pop(
                                                              context);

                                                          if (resp['message'] ==
                                                              "expiro") {
                                                            await funciones
                                                                .closeSection(
                                                                    context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacementNamed(
                                                                    'IniciarSesion');
                                                            return alerta(
                                                                context,
                                                                titulo:
                                                                    'alerta',
                                                                code: false,
                                                                contenido:
                                                                    'Tiempo de conexion agotado, inicie sesion nuevamente.');
                                                          }

                                                          if (resp['message'] ==
                                                              "true") {
                                                            var respModel =
                                                                respSucursalFromJson(
                                                                    resp['resp']
                                                                        .body);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    'SucursalAliado',
                                                                    arguments: {
                                                                  "data":
                                                                      respModel
                                                                          .data
                                                                });
                                                          }
                                                        } catch (e) {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          return alerta(context,
                                                              contenido: Text(
                                                                  e.toString()),
                                                              acciones:
                                                                  Container());
                                                        }
                                                      },
                                                      color: amarillo,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                              },
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: rojo,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Icon(
                                    Icons.delete,
                                    size: size.width > 642
                                        ? 16.05
                                        : size.width * 0.025,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  copiarSucursal(BuildContext context, dynamic element) {
    // List<Widget> widgets = [];

    // print('si');

    return alerta(
      context,
      titulo: 'Seleccione la sucursal a Duplicar',
      code: true,
      contenido: CopiarSucursal(
        element: element,
      ),
    );
  }
}

class CopiarSucursal extends StatefulWidget {
  dynamic element;
  CopiarSucursal({
    Key key,
    this.element,
  }) : super(key: key);
  @override
  _CopiarSucursalState createState() => _CopiarSucursalState();
}

class _CopiarSucursalState extends State<CopiarSucursal> {
  PeticionesHttpProvider _http = PeticionesHttpProvider();
  Funciones _funciones = new Funciones();
  int select_sucursal_id;
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    widgets = [];
    widget.element['data'].forEach((item) {
      widgets.add(GestureDetector(
        onTap: () {
          select_sucursal_id = item.id;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 15.0,
          ),
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 400,
                          child: Text(
                            'Nombre: ' + item.nombre,
                            style: TextStyle(
                              color: select_sucursal_id != item.id
                                  ? blanco
                                  : verde,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: 400,
                            child: Text(
                              'Direccion' + item.direccion,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: select_sucursal_id != item.id
                                      ? blanco
                                      : verde),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: select_sucursal_id != item.id
                      ? verde
                      : Colors.amberAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black12)]),
              width: 500,
              height: 75),
        ),
      ));
    });
    return Column(
      children: widgets
        ..add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: blanco, fontWeight: FontWeight.bold),
                ),
                color: rojo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: select_sucursal_id == null
                    ? null
                    : () {
                        _submit_copiar_sucursal();
                      },
                child: Text(
                  'Copiar',
                  style: TextStyle(color: blanco, fontWeight: FontWeight.bold),
                ),
                color: verde,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        )),
    );
  }

  _submit_copiar_sucursal() async {
    load(context);
    Map _resp = await _http.getMethod(
        table: 'sucursales?id_sucursal_copia=$select_sucursal_id',
        token: pref.token);
    Navigator.pop(context);
    if (_resp['message'] == 'expiro') {
      alerta(context,
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      _funciones.closeSection(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'IniciarSesion');
    }

    if (_resp['message'] == 'true') {
      // alerta(context,
      //     code: false, contenido: 'La sucursal se duplico satisfactoriamente');
      Navigator.pop(context);
      Navigator.pop(context);
      var respModel = respSucursalFromJson(_resp['resp']);
      Navigator.of(context).pushNamed('SucursalAliado',
          arguments: {"data": respModel.data.data});
      //0011
    }
    if (_resp['message'] == 'false') {
      return alerta(context, code: false, contenido: 'Error con el servidor');
    }
  }
}
