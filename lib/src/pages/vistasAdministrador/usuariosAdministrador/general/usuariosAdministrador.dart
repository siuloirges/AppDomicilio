import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/administrar/administrar/administrar.dart';

class UsuariosAdministrador extends StatelessWidget {
  const UsuariosAdministrador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuarios',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: Administrar(
        crear: true,
        tituloCard1: 'TOTAL DE USUARIOS APP',
        tituloCard2: 'TOTAL DE USUARIOS ACTIVOS',
        tituloCard3: 'TOTLA DE USUARIOS INACTIVOS',
        notificar1: true,
        cantidad1: 250,
        cantidad2: 74,
        cantidad3: 176,
        ruta1: 'SeleccionCrearUsuario',
        imageCard: 'assets/company.png',
      ),
    );
  }
}
