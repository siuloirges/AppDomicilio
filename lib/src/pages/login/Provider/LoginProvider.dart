// import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:traelo_app/src/pages/login/Model/LoginModel.dart';
import 'package:traelo_app/src/pages/login/Model/ResploginModel.dart';
import 'package:traelo_app/src/pages/login/Model/loginRespModel.dart';
// import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
import 'package:http/http.dart' as http;
import 'package:traelo_app/src/utils/preferencias.dart';
import 'package:traelo_app/src/utils/provider/push_notifications_provider.dart';
import 'package:traelo_app/src/utils/provider/RefrescarToken.dart';

class LoginProvider extends ChangeNotifier {
  PreferenciasUsuario pref = new PreferenciasUsuario();
  RefrescarTokenProvider refrescarToken = new RefrescarTokenProvider();
  String _respuesta;
  String get getResp => _respuesta;

  login(BuildContext context, {LoginModel user}) async {
    Map<String, String> head = {
      'Accept': 'application/json',
    };

    try {
      // String url = 'http://$ip/traeloo_database/public/api';
      dynamic resp = await http
          .post(url + '/login',
              body: {
                "username": "${user.username}",
                "password": "${user.password}",
                "fcm_token": PushNotificationsProviders.token
              },
              headers: head)
          .timeout(Duration(seconds: 30), onTimeout: () {
        throw {
          Navigator.pop(context),
          alert(context: context, texto: "No hay conexion con el servidor."),
        };
      });

      var json = jsonDecode(resp.body); //
      print('----0----');

      if (json == "Invalid Request. Please enter a username or a password." ||
          json == "Your credentials are incorrect. Please try again") {
        Navigator.pop(context);
        return alerta(context,
            titulo: 'incorrecto',
            contenido: Text(
              'Este usuario no existe.',
              style: TextStyle(color: rojo, fontWeight: FontWeight.bold),
            ),
            acciones: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.grey),
                child: Center(
                    child: Icon(Icons.arrow_back_rounded, color: Colors.white)),
              ),
            ));
      }
      print('----1----G');
      try {
        final respLoginModel = respLoginModelFromJson(resp.body);
        print('----2----G');
        if (respLoginModel.accessToken != null) {
          //00110011
          print('----3----G');
          //  Navigator.pop(context);
          Map<String, String> headGetUser = {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${respLoginModel.accessToken.toString()}'
          };

          var user;
          try {
            user = await http.get(
              url + '/get_user',
              headers: headGetUser,
            );
            print('----4----G');
            print(user.body.toString());
            // var json = jsonDecode(user.body);
            final usuarioModel = respUserModelFromJson(user.body);
            print('----5----G');
            // dynamic tipo_Documento
            Navigator.pop(context);
            //
            return alerta(
              context,
              dismissible: false,
              titulo: 'enhorabuena',
              contenido: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'bienvenido ',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${usuarioModel.data.nombre}!',
                      style: TextStyle(
                          color: verdeClaro, fontWeight: FontWeight.bold)),
                ],
              ),
              acciones: Container(
                // width: ,
                height: 50,

                child: RaisedButton(
                  elevation: 0,
                  color: verdeClaro,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    pref.rol = usuarioModel.data.rol;
                    pref.token = respLoginModel.accessToken;
                    pref.refresh_token = respLoginModel.refreshToken;
                    pref.id_aliado = usuarioModel.data.idAliado;
                    pref.user_id = usuarioModel.data.id.toString();
                    pref.nombre = usuarioModel.data.nombre;
                    pref.tipo_documento = usuarioModel.data.tipoDocumentoId;
                    pref.numero_documento =
                        usuarioModel.data.numeroDocumento.toString();
                    pref.telefono = usuarioModel.data.telefono.toString();
                    pref.email = usuarioModel.data.email;
                    pref.id_sucursal = usuarioModel.data.idSucursal.toString();
                    pref.url_foto_perfil = usuarioModel.data.urlFotoPerfil;

                    //repartidor
                    if (usuarioModel.data.rol == 'repartidor') {
                      pref.foto_documento_identidad_1 =
                          usuarioModel.data.fotoDocumentoIdentidad1;
                      pref.foto_documento_identidad_2 =
                          usuarioModel.data.fotoDocumentoIdentidad2;
                      pref.foto_soat_1 = usuarioModel.data.fotoSoat1;
                      pref.foto_soat_2 = usuarioModel.data.fotoSoat2;
                      pref.foto_targeta_propiedad_1 =
                          usuarioModel.data.fotoSoat1;
                      pref.foto_targeta_propiedad_2 =
                          usuarioModel.data.fotoSoat2;
                      pref.foto_vehiculo_1 = usuarioModel.data.fotoVehiculo1;
                      pref.foto_vehiculo_2 = usuarioModel.data.fotoVehiculo2;
                    }
                    refrescarToken.refreshToken();
                    // .replaceAll(new RegExp(r'.%20'), '');

                    Navigator.pop(context);

                    // try {
                    Navigator.pushReplacementNamed(
                        context, 'inicio${usuarioModel.data.rol}');
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                  child: Center(
                      child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              // acciones: Container()
            );
            // userResp = user;
          } catch (e) {
            print('----6----B');
            Navigator.pop(context);
            return alert(context: context, texto: '$e');
          }
        } else {
          print('----7----B');
          Navigator.pop(context);
          return alerta(context,
              titulo: 'Mensaje', contenido: Text('${resp.body}'));
        }
      } catch (e) {
        print('----8----B');
        return alerta(context, titulo: 'Mensaje', contenido: Text('$e'));
      }
    } catch (e) {
      print('----9----B');
      // _respuesta = resp.body;

      Navigator.pop(context);
      return alerta(context,
          // titulo: 'Error',
          contenido: Text('$e'),
          acciones: Container(
            width: 55,
            height: 55,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ));
    }
  }

  alert({BuildContext context, String texto}) {
    return alerta(
      context,
      acciones: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 5),
            child: Container(
              width: 56,
              height: 56,
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.black26,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ],
                )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      contenido: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
            child: Text(
          '$texto',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        )),
      ),
    );
  }
}
