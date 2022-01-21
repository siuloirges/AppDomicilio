import 'package:flutter/cupertino.dart';

class MostrarProveedorProvider extends ChangeNotifier{
  List<Map> _lista;
  

 set setCarrito(Map item) {
   _lista.add({
    'estado':'${item['estado']}',
    'cliente_id':'${item['cantidad']}',
   });
   notifyListeners();

 }
 

List<Map> get getDireccion => _lista;



}