import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GuardarCoordenadas extends ChangeNotifier {
  LatLng _coordenadas;
  String _direccion;

  LatLng get getCoordenadas => _coordenadas ;

  set obtenerCoordenadas(LatLng coordenadas) {
    _coordenadas = coordenadas;
    buscarDireccion();
    notifyListeners();
  }

  String get getDireccion => _direccion;

  buscarDireccion() async {

  _direccion = 'Actualizando...';
  final _ip = 'https://nominatim.openstreetmap.org/reverse/?format=json';
  final resp = await http
      .get(
          _ip + '&lat=${_coordenadas.latitude}&lon=${_coordenadas.longitude}')
      .catchError((onError) {
    print('Provider: ' + onError);
  });
  final respJson = json.decode(resp.body);
  _direccion = respJson['display_name'];
  notifyListeners();
  print('Provider: ' + _direccion);
  
}

reset(){
  _direccion = null;
  _coordenadas = null;
}

}
