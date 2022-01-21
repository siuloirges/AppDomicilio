import 'dart:async';
// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/PeticionesHttp.dart';
import 'package:geodesy/geodesy.dart';

class RastreoProvider extends ChangeNotifier {
  // final _rastreoStreamController = StreamController<Map>.broadcast();
  // Stream<Map> get mensajesStream => _rastreoStreamController.stream;
  bool _activo = false;
  PeticionesHttpProvider _http = new PeticionesHttpProvider();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  Geolocator _location = new Geolocator();
  Geodesy _geodesy = new Geodesy();
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  bool get getStatus => _activo;

  toggle() {
    _activo ?  _activo = false:  _start();
    notifyListeners();
  }

  _start() {
    _activo = true;
    _getLocation();
  }

  _getLocation()  {
    Future.delayed(const Duration(minutes: 1), () async {
        bool _status = await geolocator.isLocationServiceEnabled();    
      if (_activo&&_status) {
        print('Activo: $_activo');
        print('calculando');
        double distance;
        Map ubicacion;
        _location.getCurrentPosition().then((location) {
          ubicacion = {
            "latitude": "${location.latitude}",
            "longitude": "${location.longitude}"
          };
          if (_pref.last_location != null) {
            distance = _geodesy.distanceBetweenTwoGeoPoints(
                LatLng(
                    double.parse(_pref.last_location['latitude'].toString()),
                    double.parse(_pref.last_location['longitude'].toString())
                ),
                LatLng(location.latitude, location.longitude));
            print("====== " + distance.toString() + " =======");
            if (distance > 50) {
              _sendLocation(ubicacion);
            }
          } else {
            _sendLocation(ubicacion);
          }
          _getLocation();
        });
      }else{
        print('Activo: $_activo');
        _activo = false;
        notifyListeners();
        _getLocation();
      }
    });
    
  }

  _sendLocation(Map ubicacion) {
      _http.postMethod(
          table: 'update_location', body: ubicacion, token: _pref.token);
      _pref.last_location = ubicacion;
    // try {
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
