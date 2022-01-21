import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/Widgets/administrar/administrar/administrar.dart';

class ClientesAdministrador extends StatelessWidget {
  const ClientesAdministrador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clientes',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: verde),
        backgroundColor: amarillo,
        elevation: 0,
      ),
      body: Administrar(
        tituloCard1: 'TOTAL DE CLIENTES',
        tituloCard2: 'CLIENTES ACTIVOS',
        tituloCard3: 'CLIENTES INACTIVOS',
        notificar3: true,
        notificar2: true,
        cantidad1: 325,
        cantidad2: 154,
        cantidad3: 171,
        ruta1: 'RegistrarClienteAdminPage',
        ruta2: 'ConsultarClienteAdministrador',
        ruta3: 'ActualizarClienteAdministrador',
        imageCard: 'assets/food-delivery.png',
      ),
    );
  }
}
