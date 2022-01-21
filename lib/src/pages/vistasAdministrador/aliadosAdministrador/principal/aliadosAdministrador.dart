import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/administrar/administrar/administrar.dart';
// import 'package:traelo_app/src/utils/Widgets/administrar/tarjetaStack.dart';
// import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';

class AliadosAdministrador extends StatelessWidget {
  const AliadosAdministrador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aliados',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: Administrar(
        tituloCard1: 'TOTAL DE ALIADOS',
        tituloCard2: 'ALIADOS CERRADOS',
        tituloCard3: 'ALIADOS CERRADOS',
        notificar1: true,
        cantidad1: 250,
        cantidad2: 74,
        cantidad3: 176,
        // ruta1: 'ActualizarAliadoAdmin',
        ruta2: 'ConsultarAliadoAdmin',
        ruta3: 'ActualizarAliadoAdmin',
        imageCard: 'assets/company.png',
      ),
    );
  }
}
