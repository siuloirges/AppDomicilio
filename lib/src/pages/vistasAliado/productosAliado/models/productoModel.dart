// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({

        this.titulo,
        this.descripcion,
        this.precio,
        this.disponibilidad,
        this.codigo,
        this.idAliado,
        this.idCategoriaProducto,
        // this.existencia,
        this.isCombo,
        this.precioPromo,
        this.isPromo,
        this.urlImagenProducto,
        this.id

    });

    String urlImagenProducto;
    // url_imagen_producto
    int id;
    String titulo;
    String descripcion;
    String precio;
    int disponibilidad;
    String codigo;
    dynamic idAliado;
    int idCategoriaProducto;
    // String existencia;
    int isCombo;
    int isPromo;
    String precioPromo;

    // "is_combo":false,
    // "precio_promo":"12312312"

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(

        titulo: json["titulo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        disponibilidad: int.parse(json["disponibilidad"].toString()),
        codigo: json["codigo"],
        idAliado: json["id_aliado"],
        idCategoriaProducto: int.parse(json["id_categoria_producto"].toString()),
        // existencia: json["existencia"],
        isCombo: int.parse(json["is_combo"].toString()),
        precioPromo: json["precio_promo"],
        isPromo: int.parse(json["is_promo"].toString()),
        urlImagenProducto: json["url_imagen_producto"],
        id: int.parse(json["id"].toString()),
        
    );

    Map<String, dynamic> toJson() => {

      "titulo": titulo,
      "descripcion": descripcion,
      "precio": precio,
      "disponibilidad": disponibilidad,
      "codigo": codigo,
      "id_aliado": idAliado,
      "id_categoria_producto": idCategoriaProducto,
      // "existencia": existencia,
      "is_combo":isCombo,
      "precio_promo":precioPromo,
      "is_promo":isPromo,
      "url_imagen_producto":urlImagenProducto,
      "id":id

    };
}
