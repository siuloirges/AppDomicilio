import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/administrar/administrar/administrar.dart';
// import 'package:traelo_app/src/utils/Widgets/administrar/tarjetaStack/tarjetaStack.dart';
// import 'package:traelo_app/src/utils/Widgets/cardPequenna/cardPequenna.dart';

class RepartidoresAdministradores extends StatelessWidget {
  const RepartidoresAdministradores({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    // final _orientacion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repartidores',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: Administrar(
        tituloCard1: 'TOTAL DE REPARTIDORES',
        tituloCard2: 'REPARTIDORES ACTIVOS',
        tituloCard3: 'REPARTIDORES INACTIVOS',
        notificar3: true,
        notificar2: true,
        cantidad1: 15,
        cantidad2: 7,
        cantidad3: 8,
        // ruta1: 'CrearRepartidor',
        ruta2: 'ConsultarRepartidorAdministrador',
        ruta3: 'ActualizarRepartidorGeneral',
        imageCard: 'assets/food-delivery.png',
      ),
    );
  }
}
