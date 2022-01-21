// To parse this JSON data, do
//
//     final respDetallePedio = respDetallePedioFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

RespDetallePedio respDetallePedioFromJson(String str) =>
    RespDetallePedio.fromJson(json.decode(str));

String respDetallePedioToJson(RespDetallePedio data) =>
    json.encode(data.toJson());

class RespDetallePedio {
  RespDetallePedio({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  List<Datum> data;
  String message;

  factory RespDetallePedio.fromJson(Map<String, dynamic> json) =>
      RespDetallePedio(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    this.cantidad,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.idPedido,
    this.idProducto,
    this.producto,
  });

  int id;
  int cantidad;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int idPedido;
  int idProducto;
  Producto producto;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id:json["id"]==null?null: int.parse(json["id"].toString()),
        cantidad:json["cantidad"]==null?null:int.parse( json["cantidad"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idPedido: json["id_pedido"]==null?null:int.parse(json["id_pedido"].toString()),
        idProducto:json["id_producto"]==null?null:int.parse( json["id_producto"].toString()),
        producto: Producto.fromJson(json["producto"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id_pedido": idPedido,
        "id_producto": idProducto,
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
  dynamic codigo;
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
        id:json["id"]==null?null:int.parse( json["id"].toString()),
        urlImagenProducto: json["url_imagen_producto"],
        titulo: json["titulo"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        disponibilidad: json["disponibilidad"]==null? null:int.parse(json["disponibilidad"].toString()),
        isCombo:json["is_combo"]==null?null: int.parse( json["is_combo"].toString()),
        isPromo: json["is_promo"]==null?null:int.parse( json["is_promo"].toString()),
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
        "codigo": codigo,
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
