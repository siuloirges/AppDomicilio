import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class GuardarEstadoSucursalProvider extends ChangeNotifier {
  // ------ Aliado ------- //

  File _fotoPerfilSucursal;
  File _fotoPortadaSucursal;

  get getFotoPerfilSucursal => _fotoPerfilSucursal;
  get getFotoPortadaSucursal => _fotoPortadaSucursal;

  set setFotoPerfilSucursal(File n) {
    _fotoPerfilSucursal = n;
    notifyListeners();
  }

  set setFotoPortadaSucursal(File n) {
    _fotoPortadaSucursal = n;
    notifyListeners();
  }
}
