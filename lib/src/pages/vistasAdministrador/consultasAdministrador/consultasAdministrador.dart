import 'package:flutter/material.dart';
import 'package:traelo_app/src/utils/Global.dart';

import '../../../utils/Widgets/cardBlancaScroll/prueba.dart';

class ConsultasAdministrador extends StatelessWidget {
  final bool bloqueado;
  const ConsultasAdministrador({Key key, this.bloqueado = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: amarillo,
          title: Text('Consultas', style: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PruebaWidget(
            alto: 0.3,
            anchoPequenno: true,
            datos: Column(
              children: <Widget>[
                Item(
                  texto1: 'D-002',
                  texto2: 'Leonardo',
                  texto3: bloqueado == true ? 'Bloqueado' : 'Activo',
                  colorT3: bloqueado == true ? rojo : verde,
                ),
                Item(
                  texto1: 'D-002',
                  texto2: 'Leonardo',
                  texto3: 'Solicitud de Cancelacion',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
