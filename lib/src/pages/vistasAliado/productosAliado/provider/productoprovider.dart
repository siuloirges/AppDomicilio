// import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/productoModel.dart';
// import 'package:traelo_app/src/pages/vistasAliado/productosAliado/models/respProductoModel.dart';

import 'package:traelo_app/src/utils/Global.dart';
import 'package:traelo_app/src/utils/preferencias.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/model/TipoDocumento.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/model/UsuarioModel.dart';

class ProductoProvider extends ChangeNotifier {
  PreferenciasUsuario pref = new PreferenciasUsuario();
  String success;

  List<dynamic> _producto;

  List<dynamic> get productos => _producto;

  cleanProductos() {
    _producto = [];
  }
  // String get getResp => _respuesta;

  postProducto(BuildContext context,
      {ProductoModel producto, bool edit}) async {
    load(context);
    // print("ok");
    // await Future.delayed(Duration(seconds: 4),);
    Map<String, String> head = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${pref.token}'
    };
    //   // String url = 'http://$ip/traeloo_database/public/api';
    try {
      // _respuesta=null;
      if (edit == false) {
        dynamic resp = await http.post(url + '/producto',
            body: {
              "url_imagen_producto": "${producto.urlImagenProducto}",
              "titulo": "${producto.titulo ?? null}",
              "descripcion": "${producto.descripcion ?? null}",
              "precio": "${producto.precio ?? ''}",
              "disponibilidad": "${producto.disponibilidad ?? null}",
              "codigo": "${producto.codigo ?? null}",
              "id_aliado": "${producto.idAliado ?? null}",
              "id_categoria_producto":
                  "${producto.idCategoriaProducto ?? null}",
              "is_combo": "${producto.isCombo ?? null}",
              "is_promo": "${producto.isPromo ?? null}",
              "precio_promo": "${producto.precioPromo ?? null}"
            },
            headers: head);
        return resp.body;
      } else {
        dynamic resp = await http.put(url + '/producto/${producto.id}',
            body: {
              "url_imagen_producto": "${producto.urlImagenProducto}",
              "titulo": "${producto.titulo ?? null}",
              "descripcion": "${producto.descripcion ?? null}",
              "precio": "${producto.precio ?? ''}",
              "disponibilidad": "${producto.disponibilidad ?? null}",
              "codigo": "${producto.codigo ?? null}",
              "id_aliado": "${producto.idAliado ?? null}",
              "id_categoria_producto":
                  "${producto.idCategoriaProducto ?? null}",
              "is_combo": "${producto.isCombo ?? null}",
              "is_promo": "${producto.isPromo ?? null}",
              "precio_promo": "${producto.precioPromo ?? null}"
            },
            headers: head);
        return resp.body;
      }

      // Navigator.pop(context);

      //   // Map<dynamic,dynamic> json = jsonDecode(resp.body.toString());
      //   // _respuesta=resp.body;
      //   // notifyListeners();
      //   // print('Try');

      //   // return alerta(context,contenido: Text(resp.body.toString()));

    } catch (e) {
      Navigator.pop(context);
      return alerta(context,
          contenido: Text(
            '$e',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          acciones: Container());
    }
  }

  obtenerProducto(context) async {
    try {
      _producto = [];
      // load(context);
      Map<String, String> head = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.token}'
      };
      dynamic resp = await http
          .get(url + '/producto', headers: head)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw {
          Navigator.pop(context),
          alerta(context,
              contenido: Text("No hay conexion con el servidor."),
              acciones: Container()),
        };
      });

      // print(resp.body);
      print(resp.body);
      return resp.body;
    } catch (e) {
      //  Navigator.pop(context);
      print(e);
      // Navigator.pop(context);
      //  return  alerta(context,acciones: Container(),contenido:Row(children: [
      //     Text('Error')
      //   ],), );
      return e;
    }
  }

  deleteProducto(int id) async {
    try {
      Map<String, String> head = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${pref.token}'
      };
      // String url = 'http://$ip/traeloo_database/public/api';

      dynamic resp =
          await http.delete(url + '/producto' + '/$id', headers: head);
      print(resp.body);
      // deleteResp();
      return resp.body;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
