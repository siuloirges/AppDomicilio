import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:traelo_app/src/pages/registros/model/AliadoModel.dart';
import 'package:traelo_app/src/pages/registros/model/RespAliadoModel.dart';
import 'package:traelo_app/src/pages/registros/model/TipoDocumento.dart';
import 'package:traelo_app/src/pages/registros/model/TipoVehiculoModel.dart';
import 'package:traelo_app/src/pages/registros/model/UsuarioModel.dart';
import 'package:traelo_app/src/pages/registros/model/errorsModel.dart';
import 'package:traelo_app/src/utils/Global.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/model/TipoDocumento.dart';
// import 'package:traelo_app/src/pages/registros/registroCliente/model/UsuarioModel.dart';

class UsuarioProvider extends ChangeNotifier {
  // String _respuesta;
  String _respuesta = '';

  // TipoDatosCliente  _listaTipoDocumento;

  List<String> _listaTipoVehiculo = [];
  int idAliado;
  // List<int> _listaTipoDocumentoId=[];

  // TipoDatosCliente get getListaTipoDocumento => _listaTipoDocumento;
  List<String> get getListaTipoVehiculo => _listaTipoVehiculo;
  String get getRespuesta => _respuesta;
  int get getIdAliado => idAliado;

  set setIdeAliado(int r){idAliado=null;}

  postUsuario({BuildContext context, UsuarioModel usuario}) async {
    //cargarndo...
    // load(context);

    Map<String, String> head = {'Accept': 'application/json'};
    // String url = 'http://$ip/traeloo_database/public/api';
    try {
      // _respuesta=null;
      dynamic resp = await http.post(url + '/post_user',
       body: {
         "rol": "${usuario.rol}",
         "nombre": "${usuario.nombre}",
         "tipo_documento_id": "${usuario.tipoDocumento}",
         "numero_documento": "${usuario.numeroDocumento}",
         "telefono": "${usuario.telefono}",
         "url_foto_perfil": "${usuario.urlFotoPerfil??'no'}",
         "email": "${usuario.email}",
         "password": "${usuario.password}",
         "tipo_vehiculo_id": "${usuario.tipoVehiculo ?? ''}",
         "placa_vehiculo": "${usuario.placaVehiculo ?? ''}",
         "foto_documento_identidad_1":"${usuario.fotoDocumentoIdentidad1 ?? ''}",
         "foto_documento_identidad_2":"${usuario.fotoDocumentoIdentidad2 ?? ''}",
         "foto_targeta_propiedad_1":"${usuario.fotoTargetaPropiedad1 ?? ''}",
         "foto_targeta_propiedad_2":"${usuario.fotoTargetaPropiedad2 ?? ''}",
         "foto_soat_1": "${usuario.fotoSoat1 ?? ''}",
         "foto_soat_2": "${usuario.fotoSoat2 ?? ''}",
         "foto_vehiculo_1": "${usuario.fotoVehiculo1 ?? ''}",
         "foto_vehiculo_2": "${usuario.fotoVehiculo2 ?? ''}",
         "id_aliado": "${usuario.idAliado ?? ''}",
         "id_sucursal":"${usuario.idSucursal ?? ''}"
       },
       headers: head
      );

      Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (resp.statusCode != 200) {
      return {'message': "false", 'errors': decodeResp['errors']};
    } else {
      return {'message': "true", 'data': decodeResp};
    }
    } catch (e) {
      Navigator.pop(context);

      print('error');
      print(e);
      return alert(context: context, texto: e.body);
    }
  }

  obetenerDatos(BuildContext context,{String ruta, String table, String repartidor,int idSucursal }) async {
    Map<String, String> head = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    try {
      if (repartidor == null) {
        dynamic respuestaTipoDocumento = await http
            .get(url + '/$table', headers: head)
            .timeout(Duration(seconds: 30), onTimeout: () {
         
            Navigator.pop(context);
            return alert(context: context, texto: "No hay conexion con el servidor.");
           
          
        });
        Map<String, dynamic> decodedResp = jsonDecode(respuestaTipoDocumento.body);
        final client = tipoDocumentoModelFromJson(respuestaTipoDocumento.body);
        if (client.success) {
          preparing(context, client: client, ruta: ruta, idSucursal: idSucursal??0   );
        } else {
          Navigator.pop(context);
        }
        return respuestaTipoDocumento.body;
      } else {
        dynamic respuestaTipoVehiculo = await http.get(url + '/$repartidor', headers: head);
        Map<String, dynamic> decodedResp = jsonDecode(respuestaTipoVehiculo.body);
        //print(respuestaTipoDocumento.body);
        final tipoVehiculo = tipoVehiculoModelFromJson(respuestaTipoVehiculo.body);

        dynamic respuestaTipoDocumento = await http.get(url + '/$table', headers: head);
        Map<String, dynamic> decodedRespDoc = jsonDecode(respuestaTipoDocumento.body);
        final client = tipoDocumentoModelFromJson(respuestaTipoDocumento.body);

        if (client.success) {
          preparingRepartidor(context,client: client, ruta: ruta, repartidor: tipoVehiculo);
        }
        return respuestaTipoDocumento.body;
      }
    } catch (e) {
      Navigator.pop(context);
      return alerta(context,titulo: 'error',code: false,contenido: 'No hay conexion con el servidor.');
    }
  }

  preparingRepartidor(BuildContext context,{TipoDocumentoModel client, TipoVehiculoModel repartidor, String ruta}) {
    List<String> nombre = [];
    List<int> id = [];

    List<String> nombreV = [];
    List<int> idV = [];

    client.data.forEach((element) {
      nombre.add(element.nombre);
    });

    client.data.forEach((element) {
      id.add(element.id);
    });

    repartidor.data.forEach((element) {
      nombreV.add(element.nombre);
    });

    repartidor.data.forEach((element) {
      idV.add(element.id);
    });

    Navigator.pop(context);
    Navigator.pushNamed(context, '$ruta', arguments: {
      'id': id,
      'nombre': nombre,
      'nombreV': nombreV,
      'idV': idV,
      'modeloV': repartidor,
      'modeloD': client
    });
  }

  preparing(BuildContext context, {TipoDocumentoModel client, String ruta,int idSucursal }) {
    List<String> nombre = [];
    List<int> id = [];

    client.data.forEach((element) {
      nombre.add(element.nombre);
    });

    client.data.forEach((element) {
      id.add(element.id);
    });

    Navigator.pop(context);
    Navigator.pushNamed(context, '$ruta', arguments: {
      'id': id,
      'id_sucursal':idSucursal,
      'nombre': nombre,
      "modelo": client,
      "id_aliado": "$idAliado"
    });
  }

  deleteResp() {
    _respuesta = '';
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

  postAliado({BuildContext context, AliadoModel usuario}) async {
    idAliado = null;
    Map<String, String> head = {'Accept': 'application/json'};
    // String url = 'http://$ip/traeloo_database/public/api';
    try {
      // _respuesta=null;
      dynamic resp = await http
     .post(url + '/post_aliados',
      body: {
      "nit": "${usuario.nit ?? ""}",
      "razon_social": "${usuario.razonSocial ?? ""}",
      "nombre": "${usuario.nombre ?? ""}",
      "url_foto_perfil": "${usuario.urlFotoPerfil ?? "no"}",
      "url_foto_portada":  "${usuario.urlFotoPortada ?? "no"}",
      "visible":"0",
    

     },
     headers: head)
      .timeout(Duration(seconds: 20), onTimeout: () {
         throw {
          Navigator.pop(context),
          alert(context: context, texto: "No hay conexion con el servidor."),
        };
      });

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (resp.statusCode != 200) {
      
        final errorsModel = errorsFormModelFromJson(resp.body);
        Navigator.pop(context);
        Navigator.pop(context);
        List<Widget> errors = [];
        errorsModel.errors.forEach((key, value) {
          var index = errors.length / 2;
          errors
            ..add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: amarillo,
                  child: Text(
                    '${index.toString().replaceAll(new RegExp(r'.0'), '')}',
                    // overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: verde, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  value.join(),
                  // overflow: TextOverflow.,
                ),
              ],
            ))
            ..add(Divider());
        });

        return alerta(
          context,
          contenido: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                      child: Column(
              children: errors,
            ),
          ),
       
       
        );

        // return alerta(context,contenido: Text('${errorsModel.errors}'));

      }

      if (resp.statusCode == 200) {
        idAliado = null;
        Navigator.pop(context);
        final respAliadoModel = respAliadoModelFromJson(resp.body);
        idAliado = respAliadoModel.data.id;
        notifyListeners();
        // Navigator.of(context).pushNamed('RegistroAliado');

        return idAliado;
      }
      // Navigator.pop(context);
      // return alerta(context,contenido: Text('???${resp.body.toString()}'));
      // Map<String, dynamic> decodedResp = json.decode(resp.body);

    } catch (e) {
      print('error');
      print(e);
      Navigator.pop(context);
      return alerta(context, contenido: Text('$e'));
    }
  }
}
