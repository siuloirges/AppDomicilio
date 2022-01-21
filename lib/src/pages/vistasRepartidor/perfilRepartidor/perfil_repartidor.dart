import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:traelo_app/src/utils/Widgets/elevacion_container.dart';
import 'package:traelo_app/src/utils/preferencias.dart';

class InterfazPage extends StatefulWidget {
  @override
  _InterfazPageState createState() => _InterfazPageState();
}



class _InterfazPageState extends State<InterfazPage> {
  PreferenciasUsuario _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {

    Orientation orientacion = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          floatingActionButton: Container(
            height: orientacion == Orientation.portrait
                ? size.height * 0.35
                : size.height * 0.65,
            child: Column(
              children: [
                SizedBox(
                  height: orientacion == Orientation.portrait
                      ? size.height * 0.145
                      : size.height * 0.27,
                ),
                CircleAvatar(
                    backgroundColor: verde,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            storage+_prefs.url_foto_perfil),
                        radius: orientacion == Orientation.portrait
                            ? size.width * 0.138
                            : size.width * 0.09,
                        backgroundColor: Colors.white),
                    radius: orientacion == Orientation.portrait
                        ? size.width * 0.143
                        : size.width * 0.093),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          appBar: AppBar(
            
            iconTheme: IconThemeData(color: verde),
            elevation: 0,
            // leading: Builder(
            //   builder: (context) {
            //     return IconButton(
            //       icon: Icon(Icons.menu),
            //       color: Colors.green,
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //     );
            //   },
            // ),
            backgroundColor: amarillo,
            title: Text(
              'Perfil',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  _cuerpoPerfilRepartidot(context),
                  tarjetaOrdenes(
                      context: context,
                      precio: '4,000',
                      titulo: 'Orden D001',
                      subtitulo: 'Villa Grande Mz 14 Lt 4'),
                  tarjetaOrdenes(
                      context: context,
                      precio: '4,000',
                      titulo: 'Orden D001',
                      subtitulo: 'Villa Grande Mz 14 Lt 4')
                ],
              ),
            ),
          )),
    );
  }

  Widget _cuerpoPerfilRepartidot(BuildContext context) {
    Orientation orientacion = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: orientacion == Orientation.portrait
              ? size.height * 0.2
              : size.width * 0.18,
        ),
        Row(
          children: [
            SizedBox(
                width: orientacion == Orientation.portrait
                    ? size.width * 0.05
                    : size.width * 0.1),
            Container(
              width: size.width * 0.4,
              child: Text(
                '${_prefs.nombre}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: orientacion == Orientation.portrait
                        ? size.width * 0.05
                        : size.width * 0.03,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: orientacion == Orientation.portrait
                    ? size.width * 0.12
                    : size.width * 0.18),
            Text(
              'Vehiculo:',
              style: TextStyle(
                  fontSize: orientacion == Orientation.portrait
                      ? size.width * 0.05
                      : size.width * 0.03,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            FadeInRight(
                duration: Duration(milliseconds: 500),
                child: Icon(Icons.motorcycle,
                    color: Colors.green,
                    size: orientacion == Orientation.portrait
                        ? size.width * 0.14
                        : size.width * 0.07))
          ],
        ),
        SizedBox(
            height: orientacion == Orientation.portrait
                ? size.height * 0.03
                : size.height * 0.1),
        Container(
          height: orientacion == Orientation.portrait
              ? size.height * 0.05
              : size.height * 0.105,
          width: orientacion == Orientation.portrait
              ? size.width * 0.4
              : size.width * 0.21,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: verde,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white),
                  Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('editarPerfilRepartidor');
              }),
        ),
        SizedBox(
            height: orientacion == Orientation.portrait
                ? size.height * 0.06
                : size.height * 0.13),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width * 0.06),
            Text(
              'Ultimas Ordenes',
              style: TextStyle(
                  color: Color.fromRGBO(155, 155, 155, 1),
                  fontSize: orientacion == Orientation.portrait
                      ? size.width * 0.04
                      : size.width * 0.02),
            ),
            SizedBox(width: size.width * 0.25),
            Text(
              'Estatus',
              style: TextStyle(
                  color: Color.fromRGBO(155, 155, 155, 1),
                  fontSize: orientacion == Orientation.portrait
                      ? size.width * 0.04
                      : size.width * 0.02),
            ),
          ],
        ),
        SizedBox(
          height: orientacion == Orientation.portrait
              ? size.height * 0.02
              : size.height * 0.05,
        ),
      ],
    );
  }

  Widget tarjetaOrdenes(
      {BuildContext context, String precio, String titulo, String subtitulo}) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Card(
       
        child: Column(children: [
          Container(
            width:
                orientation == Orientation.portrait ? size.width : size.width,
            height: orientation == Orientation.portrait
                ? size.height * 0.130
                : size.height * 0.200,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: size.width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: orientation == Orientation.portrait
                              ? size.width * 0.4
                              : size.width * 0.6,
                          child: Text(
                            titulo ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: orientation == Orientation.portrait
                              ? size.width * 0.4
                              : size.width * 0.6,
                          child: Text(
                            subtitulo ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(103, 96, 95, 1)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: orientation == Orientation.portrait
                          ? size.height * 0.04
                          : size.height * 0.08,
                      width: orientation == Orientation.portrait
                          ? size.width * 0.33
                          : size.width * 0.18,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: Colors.yellow,
                          child: Text(
                            'En Proceso',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {}),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Icon(Icons.arrow_forward_ios),
                    SizedBox(width: size.width * 0.05),
                  ],
                ),
              ],
            ),
          ),
          Container(
              width:
                  orientation == Orientation.portrait ? size.width : size.width,
              height: orientation == Orientation.portrait
                  ? size.height * 0.040
                  : size.height * 0.085,
              color: Color.fromRGBO(251, 251, 251, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Text(
                        '\$ ' + precio,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: verde,
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(height: 7,)
        ]),
      ),
    );
  }
}
