// To parse this JSON data, do
//
//     final respDetallePedioRepartoidor = respDetallePedioRepartoidorFromJson(jsonString);

import 'dart:convert';

RespDetallePedioRepartoidor respDetallePedioRepartoidorFromJson(String str) => RespDetallePedioRepartoidor.fromJson(json.decode(str));

String respDetallePedioRepartoidorToJson(RespDetallePedioRepartoidor data) => json.encode(data.toJson());

class RespDetallePedioRepartoidor {
    RespDetallePedioRepartoidor({
        this.success,
        this.data,
        this.message,
    });

    bool success;
    List<Datum> data;
    String message;

    factory RespDetallePedioRepartoidor.fromJson(Map<String, dynamic> json) => RespDetallePedioRepartoidor(
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
        id:int.parse( json["id"].toString()),
        cantidad:int.parse( json["cantidad"].toString()),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idPedido:int.parse( json["id_pedido"].toString()),
        idProducto:int.parse( json["id_producto"].toString()),
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
        id: json["id"],
        urlImagenProducto: json["url_imagen_producto"],
        titulo: json["titulo"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        disponibilidad: json["disponibilidad"],
        isCombo: json["is_combo"],
        isPromo: json["is_promo"],
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
