// To parse this JSON data, do
//
//     final respCategoriaExistencia = respCategoriaExistenciaFromJson(jsonString);

import 'dart:convert';

RespCategoriaExistencia respCategoriaExistenciaFromJson(String str) =>
    RespCategoriaExistencia.fromJson(json.decode(str));

String respCategoriaExistenciaToJson(RespCategoriaExistencia data) =>
    json.encode(data.toJson());

class RespCategoriaExistencia {
  RespCategoriaExistencia({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory RespCategoriaExistencia.fromJson(Map<String, dynamic> json) =>
      RespCategoriaExistencia(
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
    this.idProducto,
    this.nombre,
    this.idCategoria,
    this.idSucursal,
    this.idAliado,
    this.existencia,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.producto,
  });

  int id;
  int idProducto;
  String nombre;
  int idCategoria;
  int idSucursal;
  int idAliado;
  String existencia;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Producto producto;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : int.parse(json["id"].toString()),
        idProducto: json["id_producto"] == null
            ? null
            : int.parse(json["id_producto"].toString()),
        nombre: json["nombre"],
        idCategoria: json["id_categoria"] == null
            ? null
            : int.parse(json["id_categoria"].toString()),
        idSucursal: json["id_sucursal"] == null
            ? null
            : int.parse(json["id_sucursal"].toString()),
        idAliado: json["id_aliado"] == null
            ? null
            : int.parse(json["id_aliado"].toString()),
        existencia: json["existencia"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        producto: Producto.fromJson(json["producto"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_producto": idProducto,
        "nombre": nombre,
        "id_categoria": idCategoria,
        "id_sucursal": idSucursal,
        "id_aliado": idAliado,
        "existencia": existencia,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "producto": producto.toJson(),
      };
}

class Producto {
  Producto({
    this.id,
    this.urlImagenProducto,
    this.titulo,
    this.codigo,
    this.descripcion,
    this.precio,
    this.disponibilidad,
    this.isCombo,
    this.isPromo,
    this.precioPromo,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.idAliado,
    this.idCategoriaProducto,
  });

  int id;
  String urlImagenProducto;
  String titulo;
  String codigo;
  String descripcion;
  String precio;
  int disponibilidad;
  int isCombo;
  int isPromo;
  String precioPromo;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String idAliado;
  String idCategoriaProducto;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: int.parse(json["id"].toString()),
        urlImagenProducto: json["url_imagen_producto"],
        titulo: json["titulo"],
        codigo: json["codigo"] == null ? null : json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        disponibilidad: int.parse(json["disponibilidad"].toString()),
        isCombo: int.parse(json["is_combo"].toString()),
        isPromo: int.parse(json["is_promo"].toString()),
        precioPromo: json["precio_promo"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idAliado: json["id_aliado"],
        idCategoriaProducto: json["id_categoria_producto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url_imagen_producto": urlImagenProducto,
        "titulo": titulo,
        "codigo": codigo == null ? null : codigo,
        "descripcion": descripcion,
        "precio": precio,
        "disponibilidad": disponibilidad,
        "is_combo": isCombo,
        "is_promo": isPromo,
        "precio_promo": precioPromo,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_aliado": idAliado,
        "id_categoria_producto": idCategoriaProducto,
      };
}
