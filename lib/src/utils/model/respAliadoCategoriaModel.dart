// To parse this JSON data, do
//
//     final respAliadoCategoria = respAliadoCategoriaFromMap(jsonString);

import 'dart:convert';

RespAliadoCategoria respAliadoCategoriaFromMap(String str) =>
    RespAliadoCategoria.fromMap(json.decode(str));

String respAliadoCategoriaToMap(RespAliadoCategoria data) =>
    json.encode(data.toMap());

class RespAliadoCategoria {
  RespAliadoCategoria({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory RespAliadoCategoria.fromMap(Map<String, dynamic> json) =>
      RespAliadoCategoria(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
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
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
      currentPage: json["current_page"] == null
          ? null
          : int.parse(json["current_page"].toString()),
      data: json["data"] == null
          ? null
          : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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
          json["total"] == null ? null : int.parse(json["total"].toString()));

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
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
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.estado,
    this.idAliado,
    this.idCategoria,
    this.aliado,
  });

  int id;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int estado;
  int idAliado;
  int idCategoria;
  Aliado aliado;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        estado: json["estado"] == null
            ? null
            : int.parse(json["estado"].toString()),
        idAliado: json["id_aliado"] == null
            ? null
            : int.parse(json["id_aliado"].toString()),
        idCategoria: json["id_categoria"] == null
            ? null
            : int.parse(json["id_categoria"].toString()),
        aliado: Aliado.fromMap(json["aliado"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "estado": estado,
        "id_aliado": idAliado,
        "id_categoria": idCategoria,
        "aliado": aliado.toMap(),
      };
}

class Aliado {
  Aliado({
    this.id,
    this.nombre,
    this.razonSocial,
    this.nit,
    this.urlFotoPerfil,
    this.urlFotoPortada,
    this.visible,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.sucursales,
  });

  int id;
  String nombre;
  String razonSocial;
  int nit;
  String urlFotoPerfil;
  String urlFotoPortada;
  int visible;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Sucursale> sucursales;

  factory Aliado.fromMap(Map<String, dynamic> json) => Aliado(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        nombre: json["nombre"],
        razonSocial: json["razon_social"],
        nit: json["nit"] == null ? null : int.parse(json["nit"].toString()),
        urlFotoPerfil: json["url_foto_perfil"],
        urlFotoPortada: json["url_foto_portada"],
        visible: json["visible"] == null
            ? null
            : int.parse(json["visible"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sucursales: List<Sucursale>.from(
            json["sucursales"].map((x) => Sucursale.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "razon_social": razonSocial,
        "nit": nit,
        "url_foto_perfil": urlFotoPerfil,
        "url_foto_portada": urlFotoPortada,
        "visible": visible,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sucursales": List<dynamic>.from(sucursales.map((x) => x.toMap())),
      };
}

class Sucursale {
  Sucursale({
    this.id,
    this.nombre,
    this.direccion,
    this.latitude,
    this.longitude,
    this.estado,
    this.urlFotoPerfil,
    this.urlFotoPortada,
    this.telefono,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.idAliado,
  });

  int id;
  String nombre;
  String direccion;
  double latitude;
  double longitude;
  String estado;
  String urlFotoPerfil;
  String urlFotoPortada;
  int telefono;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String idAliado;

  factory Sucursale.fromMap(Map<String, dynamic> json) => Sucursale(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        nombre: json["nombre"],
        direccion: json["direccion"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        estado: json["estado"],
        urlFotoPerfil: json["url_foto_perfil"],
        urlFotoPortada: json["url_foto_portada"],
        telefono: json["telefono"] == null
            ? null
            : int.parse(json["telefono"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idAliado: json["id_aliado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "estado": estado,
        "url_foto_perfil": urlFotoPerfil,
        "url_foto_portada": urlFotoPortada,
        "telefono": telefono,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_aliado": idAliado,
      };
}
