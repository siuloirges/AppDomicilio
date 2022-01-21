
import 'dart:io';

import 'package:flutter/material.dart';


class MantenerEstadoRepartidorProvider extends ChangeNotifier {

// ---------------------------SOAT---------------------------------//
  File _soatParteFrontal;  
  File _soatParteTrasera;

  get getSoatParteFrontal => _soatParteFrontal;
  get getSoatParteTrasera => _soatParteTrasera;

 

  set setSoatParteDelantera(File n) {
    _soatParteFrontal = n;
    notifyListeners();
  }

   set setSoatParteTrasera(File n) {
    _soatParteTrasera = n;
    notifyListeners();
  }
// ---------------------------SOAT---------------------------------//


// ---------------------------TargetaPropiedad---------------------------------//
  File _targetaDePropiedadTrasera;
  File _targetaDePropiedadFrontal;

  get getTargetaDePropiedadFrontal => _targetaDePropiedadFrontal;
  get getTargetaDePropiedadTrasera => _targetaDePropiedadTrasera;


  set setTargetaDePropiedadFrontal(File n) {
    _targetaDePropiedadFrontal = n;
    notifyListeners();
  }
  set setTargetaDePropiedadTrasera(File n) {
    _targetaDePropiedadTrasera = n;
    notifyListeners();
  }

  // ---------------------------TargetaPropiedad---------------------------------//


// ---------------------------Vheiculo---------------------------------//
  File _vehiculoPrimerAngulo;
  File _vehiculoSegundoAngulo;

  get getVehiculoPrimerAngulo => _vehiculoPrimerAngulo;
  get getVehiculoSegundoAngulo => _vehiculoSegundoAngulo;

  set setVhiculoPrimerAngulo(File n) {
    _vehiculoPrimerAngulo = n;
    notifyListeners();
  }
  set setVehiculoSegundoAngulo(File n) {
    _vehiculoSegundoAngulo = n;
    notifyListeners();
  }
// ---------------------------Vheiculo---------------------------------//


// ---------------------------Documento---------------------------------//
  File _docIdParteTrasera;
  File _docIdParteDelantera;

  get getDocIdParteTrasera => _docIdParteTrasera;
  get getDocIdParteDelantera => _docIdParteDelantera;

  set setDocIdParteTrasera(File n) {
    _docIdParteTrasera = n;
    notifyListeners();
  }

  set setIdParteDelantera(File n) {
    _docIdParteDelantera = n;
    notifyListeners();
  }
  // ---------------------------Documento---------------------------------//


  //----------------------Campos Repartidor-----------------//

  File _fotoPerfil;  
  String _nombre = '';
  int _tipoDocumento;
  String _documento = '';
  String _telefono = '';
  String _correo = '';
  int _tipoDeVehiculo;
  String _placaDeVehiculo = '';
  String _contrasena = '';
  String _confirmarContrasena = '';

  get getFotoPerfil => _fotoPerfil;
  get getNombre => _nombre;
  get gettipoDocumento => _tipoDocumento;
  get getDocumento => _documento;
  get getTelefono => _telefono;
  get getCorreo => _correo;
  get gettipoDeVehiculo => _tipoDeVehiculo;
  get getplacaDeVehiculo => _placaDeVehiculo;
  get getcontrasena => _contrasena;
  get getConfirmarContrasena => _confirmarContrasena;


  set setFotoPerfil(File n) {
    _fotoPerfil = n;
    notifyListeners();
  }

  set guardarNombre(n) {
    _nombre = n;
    notifyListeners();
  }

  set guardarTipoDocumento(n) {
    _tipoDocumento = n;
    notifyListeners();
  }

  set guardarDocumento(n) {
    _documento = n;
    notifyListeners();
  }

  set guardarTelefono(n) {
    _telefono = n;
    notifyListeners();
  }

  set guardarCorreo(n) {
    _correo = n;
    notifyListeners();
  }

  set guardarTipoDeVehiculo(n) {
    _tipoDeVehiculo = n;
    notifyListeners();
  }

  set guardarPlaca(n) {
    _placaDeVehiculo = n;
    notifyListeners();
  }

  set guardarContrasena(n) {
    _contrasena = n;
    notifyListeners();
  }

  set guardarConfirmarContrasena(n) {
    _confirmarContrasena = n;
    notifyListeners();
  }
  
}


