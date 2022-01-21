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
  Data data;
  String message;

  factory RespCategoriaSucursales.fromJson(Map<String, dynamic> json) =>
      RespCategoriaSucursales(
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
        currentPage: int.parse(json["current_page"].toString()),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: int.parse(json["from"].toString()),
        lastPage: int.parse(json["last_page"].toString()),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: int.parse(json["per_page"].toString()),
        prevPageUrl: json["prev_page_url"],
        to: int.parse(json["to"].toString()),
        total: int.parse(json["total"].toString()),
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
        id: int.parse(json["id"].toString()),
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        idSucursal: int.parse(json["id_sucursal"].toString()),
        idAliado: int.parse(json["id_aliado"].toString()),
      );

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
