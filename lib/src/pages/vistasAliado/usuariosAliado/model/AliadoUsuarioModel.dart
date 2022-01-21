// To parse this JSON data, do
//
//     final usuariosAliadoModel = usuariosAliadoModelFromJson(jsonString);

import 'dart:convert';

UsuariosAliadoModel usuariosAliadoModelFromJson(String str) =>
    UsuariosAliadoModel.fromJson(json.decode(str));

String usuariosAliadoModelToJson(UsuariosAliadoModel data) =>
    json.encode(data.toJson());

class UsuariosAliadoModel {
  UsuariosAliadoModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory UsuariosAliadoModel.fromJson(Map<String, dynamic> json) =>
      UsuariosAliadoModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null
            ? null
            : int.parse(json["current_page"].toString()),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] == null ? null : int.parse(json["from"].toString()),
        lastPage: json["last_page"] == null
            ? null
            : int.parse(json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"] == null
            ? null
            : int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : int.parse(json["to"].toString()),
        total:
            json["total"] == null ? null : int.parse(json["total"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
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
  int numeroDocumento;
  int telefono;
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
  String idAliado;
  int idSucursal;
  DateTime createdAt;
  DateTime updatedAt;
  String fcmToken;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        nombre: json["nombre"],
        numeroDocumento: json["numero_documento"] == null
            ? null
            : int.parse(json["numero_documento"].toString()),
        telefono: json["telefono"] == null
            ? null
            : int.parse(json["telefono"].toString()),
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
        tipoVehiculoId: json["tipo_vehiculo_id"],
        tipoDocumentoId: json["tipo_documento_id"],
        rolId: json["rol_id"],
        idAliado: json["id_aliado"],
        idSucursal: json["id_sucursal"] == null
            ? null
            : int.parse(json["id_sucursal"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
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
        "id_sucursal": idSucursal == null ? null : idSucursal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "fcm_token": fcmToken,
      };
}
