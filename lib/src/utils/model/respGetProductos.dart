// To parse this JSON data, do
//
//     final respProducto = respProductoFromJson(jsonString);

import 'dart:convert';

RespProducto respProductoFromJson(String str) => RespProducto.fromJson(json.decode(str));

String respProductoToJson(RespProducto data) => json.encode(data.toJson());

class RespProducto {
    RespProducto({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    List<Producto> data;
    String message;

    factory RespProducto.fromJson(Map<String, dynamic> json) => RespProducto(
        success: json["success"],
        data: List<Producto>.from(json["data"].map((x) => Producto.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
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
        id: json["id"],
        urlImagenProducto: json["url_imagen_producto"],
        titulo: json["titulo"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        disponibilidad:json["disponibilidad"]==null?null:int.parse( json["disponibilidad"].toString()),
        isCombo:json["is_combo"]==null?null: int.parse(json["is_combo"].toString()),
        isPromo:json["is_promo"]==null?null: int.parse(json["is_promo"].toString()),
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
