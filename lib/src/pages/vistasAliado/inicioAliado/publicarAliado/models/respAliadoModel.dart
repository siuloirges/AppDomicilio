// To parse this JSON data, do
//
//     final respAliadoCategoriaModel = respAliadoCategoriaModelFromJson(jsonString);

import 'dart:convert';

RespAliadoCategoriaModel respAliadoCategoriaModelFromJson(String str) =>
    RespAliadoCategoriaModel.fromJson(json.decode(str));

String respAliadoCategoriaModelToJson(RespAliadoCategoriaModel data) =>
    json.encode(data.toJson());

class RespAliadoCategoriaModel {
  RespAliadoCategoriaModel({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory RespAliadoCategoriaModel.fromJson(Map<String, dynamic> json) =>
      RespAliadoCategoriaModel(
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
          json["total"] == null ? null : int.parse(json["total"].toString()));

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
    this.titulo,
    this.descripcion,
    this.urlImagen,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.estado,
    this.aliadoCategoriaId,
  });

  int id;
  String titulo;
  String descripcion;
  String urlImagen;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int estado;
  int aliadoCategoriaId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id:json["id"]==null?null: int.parse(json["id"].toString()),
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        urlImagen: json["url_imagen"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        estado: json["estado"] == null
            ? null
            : int.parse(json["estado"].toString()),
        aliadoCategoriaId: json["aliado_categoria_id"] == null
            ? null
            : int.parse(json["aliado_categoria_id"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "url_imagen": urlImagen,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "estado": estado == null ? null : estado,
        "aliado_categoria_id":
            aliadoCategoriaId == null ? null : aliadoCategoriaId,
      };
}
