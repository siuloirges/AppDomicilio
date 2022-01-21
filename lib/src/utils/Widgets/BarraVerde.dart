import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

class BarraVerde extends StatelessWidget {
  final String texto;
  const BarraVerde({Key key, this.texto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _barraVerde(context),
    );
  }

  Widget _barraVerde(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final orientacion = MediaQuery.of(context).orientation;
    return Container(
      height: 40,
      width: _size.width,
      color: verde,
      child: Center(
          child: Text(
        texto ?? 'Datos de la nueva sucursal',
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
      )),
    );
  }
}
