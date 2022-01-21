// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel({
    this.rol,
    this.nombre,
    this.numeroDocumento,
    this.telefono,
    // this.fotoPerfil,
    this.email,
    this.password,
    this.tipoVehiculo,
    this.placaVehiculo,
    this.fotoDocumentoIdentidad1,
    this.fotoDocumentoIdentidad2,
    this.fotoTargetaPropiedad1,
    this.fotoTargetaPropiedad2,
    this.fotoSoat1,
    this.fotoSoat2,
    this.fotoVehiculo1,
    this.fotoVehiculo2,
    this.tipoDocumento,
    this.rolId,
    this.idAliado,
    this.urlFotoPerfil,
    this.idSucursal,
  });
  String rol;
  String nombre;
  int numeroDocumento;
  int telefono;
  // String fotoPerfil;
  String email;
  String password;
  int tipoVehiculo;
  String placaVehiculo;
  String fotoDocumentoIdentidad1;
  String fotoDocumentoIdentidad2;
  String fotoTargetaPropiedad1;
  String fotoTargetaPropiedad2;
  String fotoSoat1;
  String fotoSoat2;
  String fotoVehiculo1;
  String fotoVehiculo2;
  int tipoDocumento;
  int rolId;
  int idAliado;
  int idSucursal;
  dynamic urlFotoPerfil;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        rol: json["rol"],
        nombre: json["nombre"],
        numeroDocumento:json["numero_documento"]==null?null:int.parse(json["numero_documento"].toString()),
        telefono:json["telefono"]==null?null: int.parse(json["telefono"].toString()),
        // fotoPerfil: json["foto_perfil"],
        email: json["email"],
        password: json["password"],
        tipoVehiculo:json["tipo_vehiculo"]==null?null: int.parse(json["tipo_vehiculo"].toString()),
        placaVehiculo: json["placa_vehiculo"],
        fotoDocumentoIdentidad1: json["foto_documento_identidad_1"],
        fotoDocumentoIdentidad2: json["foto_documento_identidad_2"],
        fotoTargetaPropiedad1: json["foto_targeta_propiedad_1"],
        fotoTargetaPropiedad2: json["foto_targeta_propiedad_2"],
        fotoSoat1: json["foto_soat_1"],
        fotoSoat2: json["foto_soat_2"],
        fotoVehiculo1: json["foto_vehiculo_1"],
        fotoVehiculo2: json["foto_vehiculo_2"],
        tipoDocumento:json["tipo_documento"]==null?null: int.parse(json["tipo_documento"].toString()),
        rolId:json["rol_id"]==null?null:int.parse(json["rol_id"].toString()),
        idAliado:json["id_aliado"]==null?null:int.parse(json["id_aliado"].toString()),
        idSucursal:json["id_sucursal"]==null?null:int.parse( json["id_sucursal"]),
        urlFotoPerfil: json["url_foto_perfil"],
      );

  Map<String, dynamic> toJson() => {
        "rol": rol,
        "nombre": nombre,
        "numero_documento": numeroDocumento,
        "telefono": telefono,
        // "foto_perfil": fotoPerfil,
        "email": email,
        "password": password,
        "tipo_vehiculo": tipoVehiculo,
        "placa_vehiculo": placaVehiculo,
        "foto_documento_identidad_1": fotoDocumentoIdentidad1,
        "foto_documento_identidad_2": fotoDocumentoIdentidad2,
        "foto_targeta_propiedad_1": fotoTargetaPropiedad1,
        "foto_targeta_propiedad_2": fotoTargetaPropiedad2,
        "foto_soat_1": fotoSoat1,
        "foto_soat_2": fotoSoat2,
        "foto_vehiculo_1": fotoVehiculo1,
        "foto_vehiculo_2": fotoVehiculo2,
        "tipo_documento": tipoDocumento,
        "rol_id": rolId,
        "id_aliado": idAliado,
        "id_sucursal": idSucursal,
        "url_foto_perfil": urlFotoPerfil,
      };
}
