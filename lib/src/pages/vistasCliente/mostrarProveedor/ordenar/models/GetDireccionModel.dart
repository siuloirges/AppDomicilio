// To parse this JSON data, do
//
//     final getRespDireccionesModel = getRespDireccionesModelFromJson(jsonString);

import 'dart:convert';

GetRespDireccionesModel getRespDireccionesModelFromJson(String str) =>
    GetRespDireccionesModel.fromJson(json.decode(str));

String getRespDireccionesModelToJson(GetRespDireccionesModel data) =>
    json.encode(data.toJson());

class GetRespDireccionesModel {
  GetRespDireccionesModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory GetRespDireccionesModel.fromJson(Map<String, dynamic> json) =>
      GetRespDireccionesModel(
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
    this.direccion,
    this.latitude,
    this.longitude,
    this.referencia,
    this.tipoDirecionId,
    this.deletedAt,
    this.usuarioId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nombre;
  String direccion;
  double latitude;
  double longitude;
  dynamic referencia;
  dynamic tipoDirecionId;
  dynamic deletedAt;
  double usuarioId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        referencia: json["referencia"],
        tipoDirecionId: json["tipo_direcion_id"],
        deletedAt: json["deleted_at"],
        usuarioId: json["usuario_id"] == null
            ? null
            : double.parse(json["usuario_id"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "referencia": referencia,
        "tipo_direcion_id": tipoDirecionId,
        "deleted_at": deletedAt,
        "usuario_id": usuarioId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
