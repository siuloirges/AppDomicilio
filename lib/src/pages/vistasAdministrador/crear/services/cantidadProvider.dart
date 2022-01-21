import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasAdministrador/crear/models/categoriaModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

class TotalProvider extends ChangeNotifier {
  PeticionesHttpProvider http = new PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
  Funciones funciones = new Funciones();

  int _estadoGlobal;

  get getEstadoGlobal => _estadoGlobal;
  set setEstadoGlobal(int estado) {
    _estadoGlobal = estado;
    notifyListeners();
  }

  actualizarEstado(int estado) {
    _estadoGlobal = estado;
    notifyListeners();
  }

  funcion(BuildContext context) async {
    var resp = await http.getMethod(
      context: context,
      table: 'categorias?admin=1',
      token: pref.token,
    );
    if (resp['message'] == "expiro") {
      Navigator.of(context).pushReplacementNamed('IniciarSesion');
      alerta(context,
          titulo: 'alerta',
          code: false,
          contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
      await funciones.closeSection(context);
    }

    if (resp['message'] == 'true') {
      print(resp['data'].toString());
      actualizarEstado(resp['data']);
    }
  }
}
