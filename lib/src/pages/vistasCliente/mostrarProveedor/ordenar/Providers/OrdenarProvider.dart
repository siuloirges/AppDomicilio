import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:traelo_app/src/pages/vistasCliente/mostrarProveedor/ordenar/models/GetDireccionModel.dart';
// import 'package:traelo_app/src/pages/vistasCliente/ordenar/models/GetDireccionModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:traelo_app/src/utils/provider/funciones.dart';

class OrdenarProvider extends ChangeNotifier{
  PeticionesHttpProvider peticionesHttpProvider = new PeticionesHttpProvider();
  PreferenciasUsuario pref = new PreferenciasUsuario();
 Funciones funciones = new Funciones();
  Map _direccion;
  dynamic globalRespDirecciones='cargando';
  String _metodoDePago;

  get getDdireccion => _direccion; 
  get getGlobalRespDirecciones => globalRespDirecciones; 
  get getMetodoDePago => _metodoDePago; 

  set setDireccion(local){
    _direccion = local;
    notifyListeners();
  }
    set setMetodoDePago(String item) {
   _metodoDePago = item;
    notifyListeners();
  }
  set setGlobalRespDirecciones(local){
   globalRespDirecciones='cargando';
    notifyListeners();
  }

  pedir(context)async{
    Map _resp = await peticionesHttpProvider.getMethod(
     context: context,
     table:'direcciones',
     token: pref.token);
     if (_resp['message'] == "expiro") {
        Navigator.of(context).pushReplacementNamed('IniciarSesion');
        alerta(context,
            titulo: 'alerta',
            code: false,
            contenido: 'Tiempo de conexion agotado, inicie sesion nuevamente.');
        await funciones.closeSection(context);
      }

    if(_resp['message']=='true'){
      final getRespDireccionesModel = getRespDireccionesModelFromJson( _resp['resp']);
      if(getRespDireccionesModel.data.data.length == 0){
        globalRespDirecciones= 'vacio';
      }else{
        globalRespDirecciones=getRespDireccionesModel.data.data;
      }
    notifyListeners();
    }else{
      globalRespDirecciones = 'error';
      notifyListeners();
    }
     notifyListeners();
  }

}