
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class GuardarEstadoAliadoProvider extends ChangeNotifier{


  // ------ Aliado ------- //

  File _fotoPerfilAliado;
  File _fotoPortadaAliado;
  String _nombreAliado;
  String _razonSocial;
  String    _nit;

  get getFotoPerfilAliado => _fotoPerfilAliado;
  get getFotoPortadaAliado => _fotoPortadaAliado;
  get getNombreAliado => _nombreAliado;
  get getRazonSocial => _razonSocial;
  get getNit => _nit;

  set setFotoPerfilAliado(File n){
    _fotoPerfilAliado = n;
    notifyListeners();
  }
  set setFotoPortadaAliado(File n){
    _fotoPortadaAliado = n;
    notifyListeners();
  }
  set setNombreAliado(String n){
    _nombreAliado = n;
    notifyListeners();
  }
  set setRazonSocial(String n){
    _razonSocial = n;
    notifyListeners();
  }
  set setNit(String n){
    _nit = n;
    notifyListeners();
  }

  // ------- User ------- //

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

  set setNombre(n) {
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