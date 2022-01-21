import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de la última página

  get rol {
    return _prefs.getString('rol') ?? '';
  }

  set rol(String value) {
    _prefs.setString('rol', value);
  }

  get ultima_pagina {
    return _prefs.getString('ultima_pagina') ?? 'IniciarSesion';
  }

  set ultima_pagina(String value) {
    _prefs.setString('ultima_pagina', value);
  }

  get user_id {
    return _prefs.getString('user_id') ?? '';
  }

  set user_id(String value) {
    _prefs.setString('user_id', value);
  }

  get url_foto_perfil {
    return _prefs.getString('url_foto_perfil') ?? '';
  }

  set url_foto_perfil(String value) {
    _prefs.setString('url_foto_perfil', value);
  }

  get foto_documento_identidad_1 {
    return _prefs.getString('foto_documento_identidad_1') ?? '';
  }

  set foto_documento_identidad_1(String value) {
    _prefs.setString('foto_documento_identidad_1', value);
  }

  get foto_documento_identidad_2{
    return _prefs.getString('foto_documento_identidad_2') ?? '';
  }

  set foto_documento_identidad_2(String value) {
    _prefs.setString('foto_documento_identidad_2', value);
  }

  get foto_targeta_propiedad_1{
    return _prefs.getString('foto_targeta_propiedad_1') ?? '';
  }

  set foto_targeta_propiedad_1(String value) {
    _prefs.setString('foto_targeta_propiedad_1', value);
  }
  get foto_targeta_propiedad_2{
    return _prefs.getString('foto_targeta_propiedad_2') ?? '';
  }

  set foto_targeta_propiedad_2(String value) {
    _prefs.setString('foto_targeta_propiedad_2', value);
  }

  get foto_soat_1{
    return _prefs.getString('foto_soat_1') ?? '';
  }

  set foto_soat_1(String value) {
    _prefs.setString('foto_soat_1', value);
  }
  get foto_soat_2{
    return _prefs.getString('foto_soat_2') ?? '';
  }

  set foto_soat_2(String value) {
    _prefs.setString('foto_soat_2', value);
  }

  get foto_vehiculo_1{
    return _prefs.getString('foto_vehiculo_1') ?? '';
  }

  set foto_vehiculo_1(String value) {
    _prefs.setString('foto_vehiculo_1', value);
  }
  
  get foto_vehiculo_2{
    return _prefs.getString('foto_vehiculo_2') ?? '';
  }

  set foto_vehiculo_2(String value) {
    _prefs.setString('foto_vehiculo_2', value);
  }


  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  get numero_documento {
    return _prefs.getString('numero_documento') ?? '';
  }

  set numero_documento(String value) {
    _prefs.setString('numero_documento', value);
  }
  get last_location {
    return _prefs.getString('last_location') != null ? json.decode(_prefs.getString('last_location')) : null  ;
  }

  set last_location(Map value) {
    _prefs.setString('last_location', json.encode(value));
  }

  get tipo_documento {
    return _prefs.getString('tipo_documento') ?? '';
  }

  set tipo_documento(String value) {
    _prefs.setString('tipo_documento', value);
  }

  get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get id_aliado {
    return _prefs.getString('id_aliado') ?? '';
  }

  set id_aliado(String value) {
    _prefs.setString('id_aliado', value);
  }
   get id_sucursal {
    return _prefs.getString('id_sucursal') ?? '';
  }

  set id_sucursal(String value) {
    _prefs.setString('id_sucursal', value);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get refresh_token {
    return _prefs.getString('refresh_token') ?? '';
  }

  set refresh_token(String value) {
    _prefs.setString('refresh_token', value);
  }

  get activo {
    return _prefs.getString('activo') ?? 'false';
  }

  set activo(String value) {
    _prefs.setString('activo', value);
  }
}
