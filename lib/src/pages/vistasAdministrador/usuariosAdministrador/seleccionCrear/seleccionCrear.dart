import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/registros/Providers/RegistroProvider.dart';
import 'package:traelo_app/src/utils/Global.dart';

class SeleccionCrearUsuario extends StatelessWidget {
  UsuarioProvider usuarioProvider;

  @override
  Widget build(BuildContext context) {
    usuarioProvider = Provider.of<UsuarioProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
        title: Text('Seleccion Crear Usuario',
            style: TextStyle(color: verde, fontSize: 15)),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            size.width < 253
                ? 'seleccione el tipo'
                : size.width < 323
                    ? 'Seleccione que desea crear'
                    : size.width < 390
                        ? 'Seleccione que usuario desea crear'
                        : 'Seleccione que tipo de usuario desea crear ',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(151, 151, 151, 1), fontSize: 20),
          ),
          SizedBox(height: size.height * 0.05),
          botones(
              context: context,
              texto: 'Crear Cliente',
              // ruta: 'RegistrarClienteAdminPage'
              onpress: () {
                usuarioProvider.obetenerDatos(context,
                    ruta: 'RegistrarClienteAdminPage',
                    table: 'tipo_documentos');
                load(context);
              }),
          SizedBox(height: size.height * 0.025),
          botones(
              context: context,
              color: verde,
              texto: 'Crear repartidor',
              colorTexto: blanco,
              // ruta: 'CrearRepartidor'
              onpress: () {
                usuarioProvider.obetenerDatos(context,
                    table: 'tipo_documentos',
                    ruta: 'CrearRepartidor',
                    repartidor: 'tipo_vehiculo');
                load(context);
              }),
          SizedBox(height: size.height * 0.025),
          botones(
              context: context,
              texto: 'crear Aliado',
              // ruta: 'CrearAliadoAdmin'
              onpress: () {
                Navigator.of(context).pushNamed('PrimerRegistroAliadoAdmin');
              }),
        ],
      )),
    );
  }

  Widget botones(
      {BuildContext context,
      String texto,
      Color colorTexto,
      String ruta,
      Color color,
      Function onpress}) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 48.62,
      width: size.width > 450 ? 450 : size.width,
      child: RaisedButton(
          elevation: 0.0,
          color: color ?? amarillo,
          child: Text(texto ?? '',
              style: TextStyle(
                  fontSize: size.width > 450 ? 15 : size.height * 0.018,
                  color: colorTexto ?? verde)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          onPressed: onpress),
    );
// SizedBox(height: size.height * 0.08),
  }
}
