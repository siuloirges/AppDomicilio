// To parse this JSON data, do
//
//     final respCategoriaSucursales = respCategoriaSucursalesFromJson(jsonString);

import 'dart:convert';

RespCategoriaSucursales respCategoriaSucursalesFromJson(String str) =>
    RespCategoriaSucursales.fromJson(json.decode(str));

String respCategoriaSucursalesToJson(RespCategoriaSucursales data) =>
    json.encode(data.toJson());

class RespCategoriaSucursales {
  RespCategoriaSucursales({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory RespCategoriaSucursales.fromJson(Map<String, dynamic> json) =>
      RespCategoriaSucursales(
        success: json["success"],
        data: json["data"]['data'].length == 0
            ? null
            : List<Datum>.from(
                json["data"]['data'].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.nombre,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.idSucursal,
    this.idAliado,
  });

  int id;
  String nombre;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int idSucursal;
  int idAliado;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"] == null ? null : int.parse(json["id"].toString()),
      nombre: json["nombre"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
      idSucursal: json["id_sucursal"] == null
          ? null
          : int.parse(json["id_sucursal"].toString()),
      idAliado: json["id_aliado"] == null
          ? null
          : int.parse(json["id_aliado"].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "id_sucursal": idSucursal,
        "id_aliado": idAliado,
      };
}
