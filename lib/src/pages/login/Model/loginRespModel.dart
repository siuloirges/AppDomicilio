// To parse this JSON data, do
//
//     final respUserModel = respUserModelFromJson(jsonString);

import 'dart:convert';

RespUserModel respUserModelFromJson(String str) =>
    RespUserModel.fromJson(json.decode(str));

String respUserModelToJson(RespUserModel data) => json.encode(data.toJson());

class RespUserModel {
  RespUserModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory RespUserModel.fromJson(Map<String, dynamic> json) => RespUserModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.id,
    this.nombre,
    this.numeroDocumento,
    this.telefono,
    this.urlFotoPerfil,
    this.email,
    this.deletedAt,
    this.placaVehiculo,
    this.fotoDocumentoIdentidad1,
    this.fotoDocumentoIdentidad2,
    this.fotoTargetaPropiedad1,
    this.fotoTargetaPropiedad2,
    this.fotoSoat1,
    this.fotoSoat2,
    this.fotoVehiculo1,
    this.fotoVehiculo2,
    this.rol,
    this.tipoVehiculoId,
    this.tipoDocumentoId,
    this.rolId,
    this.idAliado,
    this.idSucursal,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  int id;
  String nombre;
  dynamic numeroDocumento;
  dynamic telefono;
  String urlFotoPerfil;
  String email;
  dynamic deletedAt;
  dynamic placaVehiculo;
  dynamic fotoDocumentoIdentidad1;
  dynamic fotoDocumentoIdentidad2;
  dynamic fotoTargetaPropiedad1;
  dynamic fotoTargetaPropiedad2;
  dynamic fotoSoat1;
  dynamic fotoSoat2;
  dynamic fotoVehiculo1;
  dynamic fotoVehiculo2;
  String rol;
  dynamic tipoVehiculoId;
  String tipoDocumentoId;
  dynamic rolId;
  dynamic idAliado;
  dynamic idSucursal;
  dynamic createdAt;
  DateTime updatedAt;
  String fcmToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        nombre: json["nombre"],
        numeroDocumento: json["numero_documento"],
        telefono: json["telefono"],
        urlFotoPerfil: json["url_foto_perfil"],
        email: json["email"],
        deletedAt: json["deleted_at"],
        placaVehiculo: json["placa_vehiculo"],
        fotoDocumentoIdentidad1: json["foto_documento_identidad_1"],
        fotoDocumentoIdentidad2: json["foto_documento_identidad_2"],
        fotoTargetaPropiedad1: json["foto_targeta_propiedad_1"],
        fotoTargetaPropiedad2: json["foto_targeta_propiedad_2"],
        fotoSoat1: json["foto_soat_1"],
        fotoSoat2: json["foto_soat_2"],
        fotoVehiculo1: json["foto_vehiculo_1"],
        fotoVehiculo2: json["foto_vehiculo_2"],
        rol: json["rol"],
        tipoVehiculoId: json["tipo_vehiculo_id"].toString(),
        tipoDocumentoId: json["tipo_documento_id"].toString(),
        rolId: json["rol_id"].toString(),
        idAliado: json["id_aliado"].toString(),
        idSucursal: json["id_sucursal"].toString(),
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "numero_documento": numeroDocumento,
        "telefono": telefono,
        "url_foto_perfil": urlFotoPerfil,
        "email": email,
        "deleted_at": deletedAt,
        "placa_vehiculo": placaVehiculo,
        "foto_documento_identidad_1": fotoDocumentoIdentidad1,
        "foto_documento_identidad_2": fotoDocumentoIdentidad2,
        "foto_targeta_propiedad_1": fotoTargetaPropiedad1,
        "foto_targeta_propiedad_2": fotoTargetaPropiedad2,
        "foto_soat_1": fotoSoat1,
        "foto_soat_2": fotoSoat2,
        "foto_vehiculo_1": fotoVehiculo1,
        "foto_vehiculo_2": fotoVehiculo2,
        "rol": rol,
        "tipo_vehiculo_id": tipoVehiculoId,
        "tipo_documento_id": tipoDocumentoId,
        "rol_id": rolId,
        "id_aliado": idAliado,
        "id_sucursal": idSucursal,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "fcm_token": fcmToken,
      };
}
