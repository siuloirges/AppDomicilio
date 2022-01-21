import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

import 'models/SucursalModel.dart';

class SucursalAsistente extends StatelessWidget {
  PreferenciasUsuario pref = PreferenciasUsuario();
  dynamic element;
  Funciones funciones = new Funciones();
  PeticionesHttpProvider http = PeticionesHttpProvider();
  @override
  Widget build(BuildContext context) {
    element = ModalRoute.of(context).settings.arguments;
    print(element['dato']);
    // final size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
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
        body: element['dato'] != null
            ? Column(
                children: [
                  sucursal(
                      context: context,
                      subtitulo: element['dato'].nombre,
                      titulo: element['dato'].direccion,
                      id: element['dato'].id,
                      sucursal: element['dato'])
                ],
              )
            : thereIsNot(imagen: 'assets/no_hay.png', texto: 'No hay sucursales'));
  }

  Widget sucursal({
    BuildContext context,
    String titulo,
    String subtitulo,
    int id,
    dynamic sucursal,
  }) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: size.width,
        height: 100,
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
                            child: Text(titulo,
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
                                Navigator.of(context).pushNamed('EditarSucursalAsistente',arguments: {"data": sucursal});
                              },
                              child: Container(
                                width: 25,
                                height: 25,
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
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
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
}
